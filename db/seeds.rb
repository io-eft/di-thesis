# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

desc = "Γενικά περί υπολογιστών και προγραμματισμού υπολογιστών. Ιστορική αναδρομή. Η δομή του υπολογιστή. Η πληροφορία στον υπολογιστή. Λογισμικό και γλώσσες προγραμματισμού. Απαιτήσεις από μια διαδικαστική γλώσσα προγραμματισμού. Εκτελέσιμα προγράμματα. Μεταγλώττιση και σύνδεση. Η γλώσσα προγραμματισμού C. Προγραμματιστικά περιβάλλοντα για την C. Ο μεταγλωττιστής gcc. Παραδείγματα απλών προγραμμάτων στην C. Χαρακτηριστικά και δυνατότητες της C. Μεταβλητές, σταθερές, τύποι και δηλώσεις. Εντολές αντικατάστασης, τελεστές και παραστάσεις. Η ροή του ελέγχου. Δομή προγράμματος, συναρτήσεις και εξωτερικές μεταβλητές. Εμβέλεια και χρόνος ζωής μεταβλητών. Αναδρομή. Διευθύνσεις θέσεων μνήμης, δείκτες και πίνακες. Δυναμική δέσμευση μνήμης. Συμβολοσειρές. Πίνακες δεικτών, δείκτες σε δείκτες και πολυδιάστατοι πίνακες. Δείκτες σε συναρτήσεις. Ορίσματα γραμμής εντολών. Απαριθμήσεις, δομές, αυτο-αναφορικές δομές (λίστες, δυαδικά δέντρα), ενώσεις, πεδία bit και δημιουργία νέων ονομάτων τύπων. Είσοδος και έξοδος. Χειρισμός αρχείων. Προεπεξεργαστής της C και μακροεντολές. Αλγόριθμοι ταξινόμησης πινάκων και αναζήτησης σε πίνακες. Οδηγίες σωστού προγραμματισμού. Συχνά προγραμματιστικά λάθη στην C. Εργαστηριακές ασκήσεις και ασκήσεις για κατ οίκον εργασία."

users = User.create([
  {name: "FirstName", surname: "Surname", email: 'admin@di.uoa.gr', password: 'admin12345'},
  {name: "FirstName", surname: "Surname", email: 'sdi0600296@di.uoa.gr', password: 'admin12345'},
  {name: "FirstName", surname: "Surname", email: 'professor@di.uoa.gr', password: 'admin12345'},
  {name: "FirstName", surname: "Surname", email: 'sdi0600297@di.uoa.gr', password: 'admin12345'},
  {name: "AFirstName", surname: "ASurname", email: 'professor2@di.uoa.gr', password: 'admin12345'}
  ])

users[0].add_role :admin
users[2].add_role :professor
users[1].add_role :undergrad
users[3].add_role :undergrad
users[4].add_role :professor

courses = Course.create([
  {code: "C01", name: 'Introduction to Programming', lecturer_id: users[2].id, description: desc},
  {code: "C02", name: 'Introduction to Programming 2', lecturer_id: users[2].id, description: desc},
  {code: "C03", name: 'Introduction to Programming 3', lecturer_id: users[4].id, description: desc}
  ])

StudentAttendsCourse.create([
  {user_id: users[1].id, course_id: courses[0].id},
  {user_id: users[3].id, course_id: courses[0].id},
  {user_id: users[1].id, course_id: courses[1].id},
  {user_id: users[3].id, course_id: courses[2].id}
  ])
