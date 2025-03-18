# World Tourism Explorer

## Project Overview

World Tourism Explorer is a Rails application that provides information about countries, cities, and tourist attractions around the world. This web application allows users to browse and search through geographic data in an intuitive interface.

## Features

- **Countries Database**: Browse through countries with information on continents, languages, and currencies
- **Cities Information**: Explore cities with population data and capital status
- **Tourist Attractions**: Discover attractions with descriptions, ratings, and entrance fees
- **Search Functionality**: Search across all data or filter by specific categories (countries, cities, or attractions)
- **Responsive Design**: Bootstrap-based interface that works on mobile and desktop devices
- **Pagination**: Easily navigate through large result sets with paginated listings

## Technical Details

### Technology Stack

- **Framework**: Ruby on Rails 7.2
- **Database**: SQLite
- **Frontend**: Bootstrap 5.3
- **Data Generation**: Faker gem for sample data
- **Pagination**: Kaminari
- **Styling**: SCSS with Bootstrap components

### Data Structure

The application uses a hierarchical data model:

- **Countries**: The top-level entity with information like name, continent, language, and currency
- **Cities**: Belong to countries and include data on population and capital status
- **Attractions**: Belong to cities and include details like descriptions, ratings, and entrance fees

### Data Sources

- **Countries**: Imported from a CSV dataset with real geographic information
- **Cities and Attractions**: Generated using the Faker gem to create realistic sample data

## Getting Started

### Prerequisites

- Ruby 3.1.2 or higher
- Rails 7.2.2 or higher
- SQLite 3

### Installation

1. Clone the repository
   ```
   git clone [repository-url]
   cd world-tourism
   ```

2. Install dependencies
   ```
   bundle install
   ```

3. Set up the database
   ```
   bin/rails db:create
   bin/rails db:migrate
   bin/rails db:seed
   ```

4. Start the server
   ```
   bin/rails server
   ```

5. Visit `http://localhost:3000` in your browser

## Usage

- **Homepage**: Browse countries from the main page
- **Search**: Use the search bar in the navigation to find specific countries, cities, or attractions
- **Navigation**: Click through details pages to explore related information
- **About Page**: Learn more about the data sources and application structure

## Project Structure

The application follows standard Rails MVC architecture:

- **Models**: Country, City, and Attraction with appropriate relationships
- **Controllers**: Handle routing, data retrieval, and search functionality
- **Views**: Present data with Bootstrap styling and responsive layouts

## Screenshots

[You could add screenshots here in a real README]

## License

[Add appropriate license information]

## Acknowledgments

- Country data source
- Bootstrap for UI components
- Ruby on Rails community
