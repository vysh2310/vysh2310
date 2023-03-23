#! /bin/sh
# Does not work with checker xml file: -checkers-selection-file "$(pwd)/misra_checker.txt" \... Need to Geck this
echo "Stage 1: Preparing CMake configuration"

if [ -d "$(pwd)/pre_commit_sqo_tmp" ]; then
  rm -r pre_commit_sqo_tmp
fi
mkdir pre_commit_sqo_tmp && cd "$(pwd)/pre_commit_sqo_tmp"
cmake -G "Sublime Text 2 - Unix Makefiles" ../
cmake --build .


echo "Stage 2: Preparing PaYC setup"

polyspace-configure -allow-overwrite -output-project "$(pwd)/PaYC_SQO" -compilation-database "$(pwd)/compile_commands.json"
echo "-- Successfully configured Polyspace project (PaYC_SQO.psprj)"
polyspace-configure -compilation-database "$(pwd)/compile_commands.json" -output-options-file "$(pwd)/options.txt" -no-sources
echo "-- Extracted options file for analysis (options.txt). Starting Analysis..."

files=$(git status --porcelain)
mkdir temp_analysis_result
for file in $files; do
	if [[ $file == *.cpp ]]; then

		# Bug finder analysis
	    echo "---- Analysing $file"
		"C:/Program Files/Polyspace as You Code/R2022a/polyspace/bin/polyspace-bug-finder-access" \
		-sources "../$file" \
		-misra-cpp all-rules \
		-options-file "$(pwd)/options.txt" \
		-results-dir "$(pwd)/temp_analysis_result/_$file"
		echo "---- Analysis complete"

		# Extract result in JSON
		"C:/Program Files/Polyspace as You Code/R2022a/polyspace/bin/polyspace-results-export" \
		-format json-sarif -results-dir "$(pwd)/temp_analysis_result/_$file/ps_results.payc" \
		-output-name "$(pwd)/temp_analysis_result/_$file/_$file.json"

	fi
done
