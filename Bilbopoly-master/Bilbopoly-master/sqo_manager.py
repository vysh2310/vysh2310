import sys
import os
import json
from typing import List

class PolyspaceCmd():
    def __init__(self):
        self.list_of_files = []
        self.directory = os.path.join(os.path.join(os.getcwd()), "pre_commit_sqo_tmp", "temp_analysis_result")

        try:
            object = os.scandir(self.directory )
            for n in object :
                if n.is_dir() or n.is_file():
                   self.list_of_files.append(n.name)
            object.close()
        except:
            self.raise_error("directories", "Directory not found")

    def raise_error(self, problem: str, details: str):

        format_list = [problem, details]
        stderr_str = """Problem reported from {}\n{}\n""".format(*format_list)

        self.stderr = stderr_str.encode()
        self.returncode = 1
        sys.stderr.buffer.write(self.stderr)
        sys.exit(self.returncode)


    def run(self):
        stderr = "Polyspace Quality gate failed. Fix following violations in the files: "
        err_counter = 0

        for file in self.list_of_files:
            json_directory = os.path.join(self.directory, file)
            json_file = file + ".json"
            json_file = os.path.join(json_directory, json_file)

            with open(json_file, 'r') as fcc_file:
                fcc_data = json.load(fcc_file)
                sqo_violations = ([rule['id'] for run in fcc_data['runs'] for rule in run['tool']['driver']['rules']])

                if len(sqo_violations) != 0:
                    err_counter += 1
                    stderr += str(str("\n") + "File name: " + str(file) + str("\n-----------------------------------------"))
                    for rule in sqo_violations:
                        stderr += str("\n" + rule)

        if err_counter > 0:
            self.raise_error("Polyspce Analysis", stderr)



def main(argv: List[str] = sys.argv):
    cmd = PolyspaceCmd()
    cmd.run()

if __name__ == "__main__":
    main()
