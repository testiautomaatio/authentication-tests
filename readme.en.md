# First Playwright Tests 🎭

The purpose of this assignment is to write your first tests using the Playwright tool. In this assignment, you will test the functionalities of a simple website, namely login and registration. The goals are to learn to perform operations (actions) such as entering text and clicking buttons, as well as verifying (assert) results, such as error messages and success notifications.

The example website used in this assignment has been created for testing practice, so it does not follow all the usual assumptions of production websites. The biggest difference is that registrations and logins made through the site **are only valid within the same browser**. Registrations and logins therefore do not affect different browsers or test cases.

Playwright runs tests in parallel and the execution order is not guaranteed, so the test browser is always reset at the beginning of each test. A registration or login you make in one test is therefore no longer valid in subsequent test cases.

> *"Playwright creates a browser context for each test. Browser context is equivalent to a brand new browser profile. This delivers full test isolation with zero overhead."*
>
> https://playwright.dev/

This document contains information related to the test cases to be implemented and the website to be tested, and the main material for writing tests can be found in [Playwright's documentation](https://playwright.dev/docs/writing-tests). In addition to text-based documentation, you can utilize numerous videos and tutorials, which can be found, for example, on Playwright's [YouTube channel](https://www.youtube.com/@Playwrightdev/videos).

For this assignment, we recommend watching the video [Generating Playwright Tests in VS Code](https://www.youtube.com/watch?v=LM4yqrOzmFE), which shows both "recording" tests and locating elements from the page using VS Code's "Pick locator" feature.

If you haven't watched the video [Introduction to Playwright for End-to-End Testing with Debbie O'Brien (JS Drops, youtube.com)](https://youtu.be/lCb9JoZFpHI) in the previous assignment, we recommend watching it to get an overview of using Playwright and its tools.


## Assignment and Testing Prerequisites

This assignment assumes that you have completed the previous assignment, where you practiced creating and installing a Playwright project and running tests. If you haven't done it yet, we recommend starting with that. Tests can be run from the command line, the Visual Studio Code editor, or Playwright's UI tool, so no specific method is specified.

The assignment repository already includes a Playwright project template, which you can install and run as follows:

```bash
npm install
npx playwright test
```

Running tests also requires installing browsers, which you have hopefully already done in the previous assignment. If necessary, [install the test browser following Playwright's instructions](https://playwright.dev/docs/browsers).


## Website to be Tested

The testing target is the example website https://authentication-6o1.pages.dev/, which contains a small number of features for logging into the service and creating user accounts. The website has been designed to be both simple and high-quality, so that it would work well as a first testing target. In terms of quality, for example, the labels and error messages for different fields have been implemented so that they are easy to identify and handle programmatically in tests.

The website is intended to be tested using a "black box" approach, meaning that writing tests should not require examining the website's source code or network traffic. However, examining HTML structures is necessary so that you can perform the required operations on text fields and buttons in tests.


### Registration

Registration on the website can be done at https://authentication-6o1.pages.dev/signUp. The test website has buttons for using external services for registration, but no functionality has been implemented for them.

Registering with this form creates a new user account that is only valid within one browser or test case.

> [!TIP]
> If you want to utilize Playwright's more advanced features, you can also save the registration and login state and reuse it in different tests. This approach is particularly useful in larger test suites where you want to avoid repeating login in each test.
>
> Read more about this at https://playwright.dev/docs/auth.


### Login

Logging in can be done at https://authentication-6o1.pages.dev/. After logging in, the user is redirected to https://authentication-6o1.pages.dev/dashboard, where a welcome message is displayed. Like registration, login is also only valid within the same session.

In addition to the temporary accounts you can create yourself, the site has predefined accounts that are always valid:

| Name     | Username             | Password                           | Env variables in GitHub \*         |
|----------|----------------------|------------------------------------|------------------------------------|
| Jane Doe | jane.doe@example.com | `ItWorksOnMyMac1!`                 | `JANE_USERNAME`, `JANE_PASSWORD`   |
| John Doe | john.doe@example.com | `AllTestsPass1!`                   | `JOHN_USERNAME`, `JOHN_PASSWORD`   |
| Alice    | alice@example.com    | `}3jc\xJnQ=E=+Q_y/%Hd311bW#6{_Oyj` | `ALICE_USERNAME`, `ALICE_PASSWORD` |
| Bob      | bob@example.com      | `nUL9zA3q=Nt7\N,0?CL&c74U,Ic)0)dN` | `BOB_USERNAME`, `BOB_PASSWORD`     |

You can use these credentials in test cases where you need login or registration with an existing user, or where you want to verify that the same account cannot be registered again.

\* *Read more about using environment variables at the end of this document.*


## Implementing Your Own Tests

Once you have installed the project dependencies and tried out the website to be tested, you can start writing your own tests. In this assignment, the goal is to write test cases for website registration and login. You can write the tests either in one file or in separate files, depending on how you want to organize your test cases. Your files must follow Playwright's test file naming convention, meaning they must end with `.spec.ts` or `.spec.js`.

Run your own tests as you write them so you can ensure they work as expected. You can run the tests either individually or all at once depending on how you want to test them. You can also use Playwright's UI tool to run the tests if you want to follow the test execution visually.


## Test Cases

Derive test cases from the following requirements and write Playwright tests for them. In each test case, appropriate actions must be performed and required assertions made to ensure that the functionality being tested works as expected. Test cases should also take into account typical error situations and their handling.


### Login

1. The service home page must contain a login form with fields for email and password, and a login button
2. A registered user must be able to sign in with their email and password
    * Login must be case-insensitive for the email field, but case-sensitive for the password field
3. After successful login, the user must be redirected to `/dashboard`, where a welcome message is shown
4. Login must prevent unauthorized access
    * Both username and password are required
    * Missing or invalid values must show error messages (invalid email or password length)
    * Failed login attempts must keep the user on login page and show an error message
5. Users can't access `/dashboard` directly without a valid login session
    * they must be redirected back to the login page
    * an error message needs to be shown
6. When a logged-in user logs out using the "Logout" button, they are redirected back to the login page

### Registration

1. Registration must be accessible both directly via `/signUp` URL and through the home page "Sign up" link
2. Name, email, and password are required for registration
    * Missing or invalid values must show error messages
3. A registration attempt with an already registered email must show an error message
    * Registration is case-insensitive for the email field, so just changing the case of letters in the email should not allow registration to succeed
4. Registration with valid data must create an account
    * A success message needs to be shown
    * The user must be redirected to the login page
5. An account created during registration must be usable for login immediately afterward (within the same browser session)


### Instructions and Examples

By writing these tests, the goal is to learn to perform various operations on page content using the features provided by Playwright. Read more about writing tests in [Playwright's documentation (playwright.dev)](https://playwright.dev/docs/writing-tests).

If you want to explore examples of Playwright tests, we have added a [demo-todo-app.spec.ts](./tests-examples/demo-todo-app.spec.ts) file to this repository, which contains examples of using actions and assertions. You can use it as a reference when writing tests and apply its examples to your own test cases. If you want to run the tests in that file, you will need to move it first to the `tests` folder so that Playwright recognizes it as a test file. However, do not submit this example file in the tests directory to GitHub, so that the tests in it do not mix with your own solutions.

> [!NOTE]
> *demo-todo-app.spec.ts* is a Playwright example licensed under the [Apache 2.0 license](https://github.com/microsoft/playwright/blob/main/LICENSE). It has been included in this assignment as teaching and example material.


### Usernames and Passwords in Environment Variables

Writing usernames, passwords, and API keys in plain text in test cases is not recommended, as they may be vulnerable to accidental disclosure. In this case, the test system passwords are public, so the problem is not significant, but it is good to practice handling passwords securely as well.

A better way to handle passwords could be to store secrets in environment variables or as secrets. Playwright tests can use environment variables, so you can save passwords, for example, in a `.env` file and read them in test cases from environment variables. The `.env` file you create can then be excluded from version control using the [.gitignore file](./.gitignore).

We recommend familiarizing yourself with environment variables and utilizing them in this assignment. You can read more about environment variables in [Playwright's documentation (playwright.dev)](https://playwright.dev/docs/test-parameterize#env-files). For file-based environment variables, you will also need the [dotenv package](https://www.npmjs.com/package/dotenv), which should be enabled at the top of the [playwright.config.ts](./playwright.config.ts) file.

> [!NOTE]
> To ensure variables work correctly in both your local development environment and GitHub Actions evaluation, only the following variables are supported:
>
> * `JANE_USERNAME` & `JANE_PASSWORD`
> * `JOHN_USERNAME` & `JOHN_PASSWORD`
> * `ALICE_USERNAME` & `ALICE_PASSWORD`
> * `BOB_USERNAME` & `BOB_PASSWORD`


## Automated Grading of the Assignment

Once you have written the test cases and verified that they work as expected, you can submit the assignment for automated review. Add the test files you created to version control and push the changes to GitHub using the `git status`, `git add`, `git commit`, and `git push` commands. After the `push` command, a GitHub action automatic review will start, which will run the tests and provide feedback on them. You can see the feedback on the actions tab of your GitHub repository.

The automated review uses the Chrome browser and the tests are run one at a time in headless mode. We recommend ensuring that the tests work locally with the following command before submission:

```bash
npx playwright test --reporter="list,html" --project=chromium
```

After submitting the assignment, your tests will be scored based on how well they validate the requirements listed above. It is therefore essential that you enter both correct and incorrect information in your tests and verify that the website state and the messages displayed on it work correctly. If necessary, review the actions tab report and test results so you can supplement your tests to cover more test cases. You can resubmit the assignment multiple times until the assignment deadline.


## About the Material

This assignment was developed by Teemu Havulinna and is licensed under [Creative Commons BY-NC-SA license](https://creativecommons.org/licenses/by-nc-sa/4.0/).

Language models and AI tools such as GitHub Copilot and ChatGPT were used in creating this assignment.
