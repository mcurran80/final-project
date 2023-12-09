with open(file, '1000_student_assignments') as csvfile:
    reader = csv.reader(csvfile, dialect='excel')
    for row in reader:

