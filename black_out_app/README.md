# About
This section concerns the implementation of the client side (mobile app) of the Black Out application. It communicates with all the required APIs 
in order to retrieve the reported outages and display them to the users.

## Architecture
The application is architected following the below layers:

- **Models**: Includes all the data representations that the application needs in order to organize and present the data.
- **Services**: Reusable components that implement basic functionality such as storing data, performing HTTP requests etc. Every service should serve a unique purpose and must not be tightly coupled
to any of the widgets that is using it.
- **Widgets**: Widgets specific to the application. If a widget lies inside this directory and not any of the child directories, must be a reusable component that can be used from any screen/dialog seamlessly.
	- **Screens**: The screens of the application.
	- **Dialogs**: The dialogs/popups presented to the users.
