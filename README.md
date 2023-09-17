# Vet clinic database


## Getting Started

This repository includes files with plain SQL that can be used to recreate a database:

- Use [schema.sql](./schema.sql) to create all tables.
- Use [data.sql](./data.sql) to populate tables with sample data.
- Check [queries.sql](./queries.sql) for examples of queries that can be run on a newly created database. **Important note: this file might include queries that make changes in the database (e.g., remove records). Use them responsibly!**

<a name="readme-top"></a>



# 📗 Table of Contents

- [📖 About the Project](#about-project)
  - [🛠 Built With](#built-with)
    - [Tech Stack](#tech-stack)
    - [Key Features](#key-features)
  - [🚀 Live Demo](#live-demo)
- [💻 Getting Started](#getting-started)
  - [Setup](#setup)
  - [Prerequisites](#prerequisites)
  - [Install](#install)
  - [Usage](#usage)
  - [Run tests](#run-tests)
  - [Deployment](#triangular_flag_on_post-deployment)
- [👥 Authors](#authors)
- [🔭 Future Features](#future-features)
- [🤝 Contributing](#contributing)
- [⭐️ Show your support](#support)
- [🙏 Acknowledgements](#acknowledgements)
- [❓ FAQ](#faq)
- [📝 License](#license)



# 📖 [Vet clinic database] <a name="about-project"></a>

**[Vet clinic database]** is a relational database created for a vet clinic. It consists of tables with data about:

- animals
- animals' owners
- clinic employees
- visits

## 🛠 Built With <a name="built-with"></a>

### Tech Stack <a name="tech-stack"></a>

<details>
<summary>Database</summary>
  <ul>
    <li><a href="https://www.postgresql.org/">PostgreSQL</a></li>
  </ul>
</details>


### Key Features <a name="key-features"></a>

- **[create_table]**
- **[add_data]**
- **[query_data]**

<p align="right">(<a href="#readme-top">back to top</a>)</p>



## 🚀 Live Demo <a name="live-demo"></a>

Live Demo link will be added in future branches.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



## 💻 Getting Started <a name="getting-started"></a>


To get a local copy up and running, follow these steps.

### Prerequisites

In order to run this project you need:

psql installed
(command for Ubuntu WSL)
```
 sudo apt install postgresql postgresql-contrib
```

PostgreSQL server running
(command for Ubuntu WSL)
```
 sudo service postgresql start
 sudo -u postgres psql
```

Follow instuctions on [PostgreSQL](https://www.postgresql.org/download/) official website.

### Setup

Clone this repository to your desired folder:

```sh
  cd my-folder
  git clone git@github.com:Zilola-Nazarova/vet-clinic-database/
```

### Install

Installation steps will be described in future branches.

### Usage

Steps for running the server will be described in future branches.

### Run tests

Steps for running tests will be described in future branches.

### Deployment

Deployment steps will be described in future branches.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



## 👥 Authors <a name="authors"></a>

👤 Zilola Nazarova

- GitHub: [@Zilola-Nazarova](https://github.com/Zilola-Nazarova)
- Twitter: [@NazarovaZi](https://twitter.com/NazarovaZi)
- LinkedIn: [in/zilola-nazarova](https://www.linkedin.com/in/zilola-nazarova)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



## 🔭 Future Features <a name="future-features"></a>

- [ ] **[add_animals'_owners_table]**
- [ ] **[add_clinic_employees_table]**
- [ ] **[add_visits_table]**

<p align="right">(<a href="#readme-top">back to top</a>)</p>



## 🤝 Contributing <a name="contributing"></a>

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](../../issues/).

<p align="right">(<a href="#readme-top">back to top</a>)</p>



## ⭐️ Show your support <a name="support"></a>

If you like this project just star it!

<p align="right">(<a href="#readme-top">back to top</a>)</p>



## 🙏 Acknowledgments <a name="acknowledgements"></a>

I would like to thank Microverse for the knowledge and skills I have acquired in Modules 1, 2 and 3.

I am grateful to all previous project reviewers for their advice. Thanks to them I could build this app.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



## ❓ FAQ <a name="faq"></a>

- **How can I install PostgreSQL?**

  - Follow instuctions on [PostgreSQL](https://www.postgresql.org/download/) official website. If you are using WSL check [Get started with databases on Windows Subsystem for Linux](https://learn.microsoft.com/en-us/windows/wsl/tutorials/wsl-database)

- **I'm getting error saying 'role "user_name" does not exist'. What should I do?**

  - After running PostgreSQL with psql shell create a role (CREATE ROLE user_name) with the user_name matching the 'user_name' you're getting in the error message.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



## 📝 License <a name="license"></a>

This project is [MIT](./LICENSE) licensed.

<p align="right">(<a href="#readme-top">back to top</a>)</p>
