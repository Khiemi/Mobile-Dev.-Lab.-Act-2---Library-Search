

//dart's I/O library since required siya sa mga gagamitin kong operations.
import 'dart:io';



//defaul books
List<String> titles = [
  'Mobile Development',
  'Python Programming2',
  'Computer Networking2',
  'Data Mining'
];
//default authors of the books
List<String> authors = [
  'Warren',
  'Paulo',
  'Joshua',
  'Emelbe'
];

//track whether the book is available or currenlty borrowed
//'0' means book is avaiulable, while '1' means currentlt borrowed
List<int> bookIssued = [0, 0, 0, 0, 0, 0, 0];
//track who  borrowed the book
List<String> issuedBy = ['', '', '', '', '', '', ''];

//Entry point ng program
void main() {
  welcome();
}


void welcome() {
  print('==========================');
  print('\tWelcome To Library\t');
  print('==========================');
  menu();
}


void menu() {
  try {
    print('=============================\n');
    print('[1]. Borrow/Issue Books\n');
    print('[2]. Display Books\n');
    print('[3]. Exit\n');
    print('============================\n');
    stdout.write('Please Choose a Number You Want:\n');
    

    
    String? input = stdin.readLineSync();
    if (input == null) return;
    int userChoice = int.parse(input.trim());

    switch (userChoice) {

      case 1:
        issueBook();
        break;

      case 2:
        if (titles.isEmpty) {
          print('There are no books in the library.\n');
          menu();
        } else {
          displayBook(0);
        }
        break;

      case 3:
        print('Exiting the program. Goodbye!\n');
        exit(0);

      default:
        print('\n Please choose a correct choice!\n');
        menu();
    }
  } catch (e) {
    print('\n[Error]: Invalid input format. Please enter a valid number.');
    menu();
  }
}

void displayBook(int display) {
  print('=======================================================\n');
  print('\n\t The list of books are: \t\n');
  print('========================================================\n');
  print(' Book ID\t Book Title\t\t\t Author\t\t\t Status\t\t Issued By');

  for (int i = 0; i < titles.length; i++) {
    String status = bookIssued[i] == 1 ? 'Issued' : 'Available';
    String issuer = bookIssued[i] == 1 ? issuedBy[i] : 'N/A';
    print(' ${i + 1}\t\t ${titles[i]}\t\t\t ${authors[i]}\t ${status}\t\t ${issuer}');
  }

  if (display != 1) {
    menu();
  }
}

void issueBook() {
  try {
    print('==============================\n');
    print('\n\t Available Books are:\t\n');
    print('==============================\n');
    print(' Book ID\t Book Title');

    int availableCount = 0;
    for (int i = 0; i < titles.length; i++) {
      if (bookIssued[i] == 0) {
        print('    ${i + 1}\t\t ${titles[i]}');
        availableCount++;
      }
    }

    if (availableCount == 0) {
      print('\n There are no books available to issue.\n');
      menu();
      return;
    }

    stdout.write('\nEnter the book ID to issue: \n');
    String? idInput = stdin.readLineSync();
    if (idInput == null) return;
    int bookIdToIssue = int.parse(idInput.trim());

    if (bookIdToIssue < 1 || bookIdToIssue > titles.length || bookIssued[bookIdToIssue - 1] == 1) {
      print('Invalid book ID or the book is already issued.\n');
      menu();
      return;
    }

    stdout.write('Enter the name of the person issuing the book: \n');
    String? issuerName = stdin.readLineSync();
    if (issuerName == null || issuerName.trim().isEmpty) {
      issuerName = 'Guest';
    }

    bookIssued[bookIdToIssue - 1] = 1;
    issuedBy[bookIdToIssue - 1] = issuerName.trim();

    print('\nSuccess: "${titles[bookIdToIssue - 1]}" is issued successfully to ${issuerName.trim()}.\n');
    menu();
  } catch (e) {
    print('\n[Error]: Invalid input during borrowing. Returning to menu.');
    menu();
  }
}