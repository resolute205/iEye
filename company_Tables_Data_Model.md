company Tables Data Model
=========================

**Data Model**
--------------

![C:\\7201d1e179a620c04c092a2e7b8b4bd6](media/494fee33885940bfe5071f341835a7cc.tmp)

**Tables Detail**
-----------------

*company_alias*
---------------

### Table Structure:

| **Field**         | **Type**     | **Null** | **Key** | **Default**       | **Extra**      |
|-------------------|--------------|----------|---------|-------------------|----------------|
| company_alias_id  | int(11)      | NO       | PRI     | NULL              | auto_increment |
| company_alias     | varchar(255) | NO       | UNI     | NULL              |                |
| counter_recruiter | int(11)      | NO       |         | 0                 |                |
| counter_job       | int(11)      | NO       |         | 0                 |                |
| counter_member    | int(11)      | NO       |         | 0                 |                |
| master_company_id | int(11)      | YES      | MUL     | NULL              |                |
| updater_id        | int(11)      | YES      |         | NULL              |                |
| update_time       | datetime     | YES      | MUL     | CURRENT_TIMESTAMP |                |
| active            | tinyint(1)   | NO       |         | 1                 |                |
| ignore_mapping    | tinyint(1)   | NO       |         | 0                 |                |
| mapping_time      | datetime     | YES      |         | NULL              |                |
| all_counter       | int(11)      | YES      | MUL     | NULL              | PERSISTENT     |

>   Note : all_counter is derived column using (counter_recruiter \* 1000 +
>   counter_job \* 100 + counter_member \* 10)

### INDEX on the table:

>   PRIMARY KEY (company_alias_id)

>   UNIQUE KEY ui_company_alias (company_alias)

>   KEY fk_ca_master_company_idx (master_company_id

>   KEY all_counter_idx (all_counter)

>   KEY update_time (update_time)

### FOREIGN KEY on the table:

>   fk_ca_master_company - master_company (master_company_id)

### TRIGGERS populating company_alias table:

>   1. job table trigger:

>   a. after delete

>   Inserts a record into company_alias table if company_name does not exist
>   (this is rare case).

>   Deletes a row from job_company_alias with OLD job_id and company_alias_id.

>   b. after insert

>   Inserts a record into company_alias table if company_name does not exist.

>   Inserts a record into job_company_alias table with NEW job_id and
>   company_alias_id.

>   c. after update

>   Inserst a row into company_alias table if OLD and NEW company_name does not
>   exist.

>   Deletes a row from job_company_alias with OLD job_id and company_alias_id.

>   inserts a record into job_company_alias table with NEW job_id and
>   company_alias_id.

>   2. recruiter_profile table trigger:

>   a. before delete (triggers fires when profile_status_id = 5)

>   Inserts a record into company_alias table if OLD company_name does not exist
>   (this is a rare case). But, it's getting company_name from company table.

>   b. before insert (triggers fires when profile_status_id = 5)

>   Inserts a record into company_alias table if NEW company_name does not exist
>   (this is a rare case). But, it's getting company_name from company table.

>   c. before update (triggers fires when profile_status_id = 5)

>   Inserts a record into company_alias table if OLD and NEW company_name does
>   not exist (this is a rare case). But, it's getting company_name from company
>   table.

>   3. member_contact table trigger:

>   a. after insert

>   Inserts a record into company_alias table if company_name does not exist.

>   b. after update

>   Inserts a record into company_alias table if company_name does not exist.

*company_status*
----------------

### Table Structure:

| **Field**                  | **Type**     | **Null** | **Key** | **Default** | **Extra**      |
|----------------------------|--------------|----------|---------|-------------|----------------|
| company_status_id          | int(11)      | NO       | PRI     | NULL        | auto_increment |
| company_status_description | varchar(100) | NO       | UNI     | NULL        |                |
| updater_id                 | int(11)      | YES      |         | NULL        |                |
| update_time                | datetime     | YES      |         | NULL        |                |

### INDEX on the table:

>   PRIMARY KEY (company_status_id)

>   UNIQUE KEY master_company_status_description_UNIQUE
>   (company_status_description)

### REFERENCE DATA:

| **company_status_id** | **company_status_description** | **updater_id** | **update_time**     |
|-----------------------|--------------------------------|----------------|---------------------|
| 1                     | Merged or Acquired             | 2837           | 2019-01-15 16:01:35 |
| 2                     | Duplicate                      | 2837           | 2019-01-15 16:01:35 |
| 3                     | Company Closed                 | 2837           | 2019-01-15 16:01:35 |

*job_company_alias*
-------------------

### Table Structure:

| **Field**        | **Type** | **Null** | **Key** | **Default**       | **Extra** |
|------------------|----------|----------|---------|-------------------|-----------|
| job_id           | int(11)  | NO       | PRI     | NULL              |           |
| company_alias_id | int(11)  | NO       | MUL     | NULL              |           |
| update_time      | datetime | YES      |         | CURRENT_TIMESTAMP |           |

### INDEX on the table:

>   PRIMARY KEY (job_id)

>   UNIQUE KEY job_id_fi (job_id)

>   KEY company_alias_id_fi (company_alias_id)

### FOREIGN KEY on the table:

>   company_alias_id_fx - company_alias (company_alias_id)

>   job_id_fk - job (job_id)

*master_company*
----------------

### Table Structure:

| **Field**              | **Type**         | **Null** | **Key** | **Default**       | **Extra**      |
|------------------------|------------------|----------|---------|-------------------|----------------|
| master_company_id      | int(11)          | NO       | PRI     | NULL              | auto_increment |
| master_company_name    | varchar(255)     | NO       | UNI     | NULL              |                |
| url                    | varchar(2000)    | NO       |         | NULL              |                |
| industry_id            | int(11)          | NO       | MUL     | NULL              |                |
| employees_number_id    | int(11)          | YES      | MUL     | NULL              |                |
| hq_street              | varchar(255)     | YES      |         | NULL              |                |
| hq_city                | varchar(100)     | YES      |         | NULL              |                |
| hq_state               | varchar(2)       | YES      |         | NULL              |                |
| hq_zipcode             | varchar(7)       | YES      |         | NULL              |                |
| hq_zip_id              | int(11)          | YES      | MUL     | NULL              |                |
| update_time            | datetime         | YES      |         | CURRENT_TIMESTAMP |                |
| updater_id             | int(11)          | YES      |         | NULL              |                |
| active                 | tinyint(1)       | NO       |         | 1                 |                |
| jobsite_id             | int(11)          | YES      | UNI     | NULL              |                |
| company_status_id      | int(11)          | YES      | MUL     | NULL              |                |
| company_claimed_by_id  | int(11)          | YES      |         | NULL              |                |
| create_time            | datetime         | YES      |         | NULL              |                |
| end_time               | datetime         | YES      |         | NULL              |                |
| default_referral_bonus | int(10) unsigned | YES      |         | NULL              |                |
| max_referral_bonus     | int(10) unsigned | YES      |         | NULL              |                |

### INDEX on the table:

>   PRIMARY KEY (master_company_id)

>   UNIQUE KEY ui_master_company_name (master_company_name)

>   UNIQUE KEY ui_master_company_jobsite (jobsite_id)

>   KEY fk_industry_idx (industry_id)

>   KEY fk_employees_number_idx (employees_number_id)

>   KEY fk_zip_id_idx (hq_zip_id)

>   KEY fk_company_status_id (company_status_id)

### FOREIGN KEY on the table:

>   fk_company_status_id - company_status (company_status_id)

>   fk_employees_number - employees_number (employees_number_id)

>   fk_industry - industry (industry_id)

>   fk_zip_id - zipnames (zip_id)

*master_company_description*
----------------------------

### Table Structure:

| **Field**                                | **Type** | **Null** | **Key** | **Default**       | **Extra**      |
|------------------------------------------|----------|----------|---------|-------------------|----------------|
| master_company_description_id            | int(11)  | NO       | PRI     | NULL              | auto_increment |
| master_company_id                        | int(11)  | NO       | UNI     | NULL              |                |
| master_company_source_id                 | int(11)  | NO       | MUL     | NULL              |                |
| master_company_description               | text     | YES      |         | NULL              |                |
| updater_id                               | int(11)  | YES      |         | NULL              |                |
| update_time                              | datetime | YES      |         | CURRENT_TIMESTAMP |                |
| master_company_description_submission_id | int(11)  | YES      | MUL     | NULL              |                |

### INDEX on the table:

>   PRIMARY KEY (master_company_description_id)

>   UNIQUE KEY master_company_description_udx01 (master_company_id)

>   KEY fk_master_company_idx (master_company_id)

>   KEY fk_mcd_source_idx (master_company_source_id)

>   KEY fk_mcd_master_company_description_submission_id
>   (master_company_description_submission_id)

### FOREIGN KEY on the table:

>   fk_master_company2 - master_company (master_company_id)

>   fk_mcd_master_company_description_submission_id -
>   master_company_description_submission
>   (master_company_description_submission_id)

>   fk_mcd_source - master_company_source (master_company_source_id)

*master_company_description_submission*
---------------------------------------

### Table Structure:

| **Field**                                | **Type** | **Null** | **Key** | **Default**       | **Extra**                   |
|------------------------------------------|----------|----------|---------|-------------------|-----------------------------|
| master_company_description_submission_id | int(11)  | NO       | PRI     | NULL              | auto_increment              |
| master_company_id                        | int(11)  | YES      | MUL     | NULL              |                             |
| master_company_source_id                 | int(11)  | YES      | MUL     | NULL              |                             |
| master_company_description               | text     | YES      |         | NULL              |                             |
| master_company_submission_status_id      | char(1)  | YES      | MUL     | NULL              |                             |
| updater_id                               | int(11)  | YES      |         | NULL              |                             |
| update_time                              | datetime | NO       |         | CURRENT_TIMESTAMP | on update CURRENT_TIMESTAMP |

### INDEX on the table:

>   PRIMARY KEY (master_company_description_submission_id)

>   UNIQUE KEY master_company_description_submission_udx01
>   (master_company_id,master_company_source_id,master_company_submission_status_id)

>   KEY fk_mcds_master_company_source_id (master_company_source_id)

>   KEY fk_mcds_master_company_submission_status_id
>   (master_company_submission_status_id)

### FOREIGN KEY on the table:

>   fk_mcds_master_company_id - master_company (master_company_id)

>   fk_mcds_master_company_source_id - master_company_source
>   (master_company_source_id)

>   fk_mcds_master_company_submission_status_id -
>   master_company_submission_status (master_company_submission_status_id)

*master_company_financial*
--------------------------

### Table Structure:

| **Field**                   | **Type**     | **Null** | **Key** | **Default**       | **Extra**      |
|-----------------------------|--------------|----------|---------|-------------------|----------------|
| master_company_financial_id | int(11)      | NO       | PRI     | NULL              | auto_increment |
| master_company_id           | int(11)      | NO       | MUL     | NULL              |                |
| master_company_source_id    | int(11)      | NO       | MUL     | NULL              |                |
| market_cap                  | varchar(50)  | YES      |         | NULL              |                |
| revenue                     | varchar(50)  | YES      |         | NULL              |                |
| 5_year_trend                | decimal(7,4) | YES      |         | NULL              |                |
| net_income                  | varchar(50)  | YES      |         | NULL              |                |
| founded                     | date         | YES      |         | NULL              |                |
| stock_ticker                | varchar(20)  | YES      |         | NULL              |                |
| stock_exchange              | varchar(50)  | YES      |         | NULL              |                |
| updater_id                  | int(11)      | YES      |         | NULL              |                |
| update_time                 | datetime     | YES      |         | CURRENT_TIMESTAMP |                |

### INDEX on the table:

>   PRIMARY KEY (master_company_financial_id)

>   UNIQUE KEY ui_msf_mastercompany_soure
>   (master_company_id,master_company_source_id)

>   KEY fk_mcf_source_idx (master_company_source_id)

### FOREIGN KEY on the table:

>   fk_mcf_master_company - master_company (master_company_id)

>   fk_mcf_source - master_company_source (master_company_source_id)

*master_company_hierarchy*
--------------------------

### Table Structure:

| **Field**                   | **Type** | **Null** | **Key** | **Default**       | **Extra**      |
|-----------------------------|----------|----------|---------|-------------------|----------------|
| master_company_hierarchy_id | int(11)  | NO       | PRI     | NULL              | auto_increment |
| master_company_id           | int(11)  | NO       | MUL     | NULL              |                |
| parent_master_company_id    | int(11)  | NO       | MUL     | NULL              |                |
| start_time                  | datetime | NO       |         | NULL              |                |
| end_time                    | datetime | YES      |         | NULL              |                |
| updater_id                  | int(11)  | YES      |         | NULL              |                |
| update_time                 | datetime | YES      |         | CURRENT_TIMESTAMP |                |

### INDEX on the table:

>   PRIMARY KEY (master_company_hierarchy_id)

>   KEY fk_mch_master_company_idx (master_company_id)

>   KEY fk_mch_parent_mastercompany_idx (parent_master_company_id)

### FOREIGN KEY on the table:

>   fk_mch_master_company - master_company (master_company_id)

>   fk_mch_parent_mastercompany - master_company (master_company_id)

*master_company_media*
----------------------

### Table Structure:

| **Field**                          | **Type**      | **Null** | **Key** | **Default**       | **Extra**      |
|------------------------------------|---------------|----------|---------|-------------------|----------------|
| master_company_media_id            | int(11)       | NO       | PRI     | NULL              | auto_increment |
| master_company_id                  | int(11)       | NO       | MUL     | NULL              |                |
| media_type_id                      | int(11)       | NO       | MUL     | NULL              |                |
| master_company_source_id           | int(11)       | NO       | MUL     | NULL              |                |
| url                                | varchar(2000) | NO       |         | NULL              |                |
| media_description                  | varchar(255)  | YES      |         | NULL              |                |
| display_order                      | int(11)       | YES      |         | 1                 |                |
| updater_id                         | int(11)       | YES      |         | NULL              |                |
| update_time                        | datetime      | YES      |         | CURRENT_TIMESTAMP |                |
| master_company_media_submission_id | int(11)       | YES      | MUL     | NULL              |                |

### INDEX on the table:

>   PRIMARY KEY (master_company_media_id)

>   UNIQUE KEY master_company_media_udx01
>   (master_company_id,master_company_source_id,media_type_id,display_order)

>   KEY fk_mcm_master_company_idx (master_company_id)

>   KEY fk_mcm_source_idx (master_company_source_id)

>   KEY fk_mcm_media_type_idx (media_type_id)

>   KEY fk_mcm_master_company_media_submission_id
>   (master_company_media_submission_id)

### FOREIGN KEY on the table:

### fk_mcm_master_company - master_company (master_company_id)

>   fk_mcm_master_company_media_submission_id - master_company_media_submission
>   (master_company_media_submission_id)

>   fk_mcm_media_type - media_type (media_type_id)

>   fk_mcm_source - master_company_source (master_company_source_id)

*master_company_media_submission*
---------------------------------

### Table Structure:

| **Field**                           | **Type** | **Null** | **Key** | **Default**       | **Extra**                   |
|-------------------------------------|----------|----------|---------|-------------------|-----------------------------|
| master_company_media_submission_id  | int(11)  | NO       | PRI     | NULL              | auto_increment              |
| master_company_id                   | int(11)  | YES      | MUL     | NULL              |                             |
| master_company_source_id            | int(11)  | YES      | MUL     | NULL              |                             |
| media_type_id                       | int(11)  | YES      | MUL     | NULL              |                             |
| url                                 | text     | YES      |         | NULL              |                             |
| media_description                   | text     | YES      |         | NULL              |                             |
| display_order                       | int(11)  | YES      |         | NULL              |                             |
| master_company_submission_status_id | char(1)  | YES      | MUL     | NULL              |                             |
| updater_id                          | int(11)  | YES      |         | NULL              |                             |
| update_time                         | datetime | NO       |         | CURRENT_TIMESTAMP | on update CURRENT_TIMESTAMP |

### INDEX on the table:

>   PRIMARY KEY (master_company_media_submission_id)

>   UNIQUE KEY master_company_media_submission_udx01
>   (master_company_id,master_company_source_id,master_company_submission_status_id)

>   KEY fk_mcms_master_company_source_id (master_company_source_id)

>   KEY fk_mcms_media_type_id (media_type_id)

>   KEY fk_mcms_master_company_submission_status_id
>   (master_company_submission_status_id)

### FOREIGN KEY on the table:

>   fk_mcms_master_company_id - master_company (master_company_id)

>   fk_mcms_master_company_source_id - master_company_source
>   (master_company_source_id)

>   fk_mcms_master_company_submission_status_id -
>   master_company_submission_status (master_company_submission_status_id)

>   fk_mcms_media_type_id - media_type (media_type_id)

*master_company_seo_name*
-------------------------

### Table Structure:

| **Field**                  | **Type**     | **Null** | **Key** | **Default**       | **Extra**      |
|----------------------------|--------------|----------|---------|-------------------|----------------|
| master_company_seo_name_id | int(11)      | NO       | PRI     | NULL              | auto_increment |
| master_company_id          | int(11)      | YES      | MUL     | NULL              |                |
| seo_name                   | varchar(255) | YES      | UNI     | NULL              |                |
| active                     | tinyint(4)   | YES      |         | 1                 |                |
| updater_id                 | int(11)      | YES      |         | NULL              |                |
| update_time                | datetime     | YES      |         | CURRENT_TIMESTAMP |                |

### INDEX on the table:

>   PRIMARY KEY (master_company_seo_name_id)

>   UNIQUE KEY ui_mcsn_master_company_active (master_company_id,active)

>   UNIQUE KEY ui_mcsn_seo_name (seo_name)

>   KEY fk_mcsn_master_company_idx (master_company_id)

### FOREIGN KEY on the table:

>   fk_mcsn_master_company - master_company (master_company_id)

*master_company_social_media*
-----------------------------

### Table Structure:

| **Field**                                 | **Type**      | **Null** | **Key** | **Default**       | **Extra**      |
|-------------------------------------------|---------------|----------|---------|-------------------|----------------|
| master_company_social_media_id            | int(11)       | NO       | PRI     | NULL              | auto_increment |
| master_company_id                         | int(11)       | NO       | MUL     | NULL              |                |
| social_media_id                           | int(11)       | NO       | MUL     | NULL              |                |
| url                                       | varchar(2000) | NO       |         | NULL              |                |
| updater_id                                | int(11)       | YES      |         | NULL              |                |
| update_time                               | datetime      | YES      |         | CURRENT_TIMESTAMP |                |
| master_company_source_id                  | int(11)       | YES      | MUL     | NULL              |                |
| master_company_social_media_submission_id | int(11)       | YES      | MUL     | NULL              |                |

### INDEX on the table:

>   PRIMARY KEY (master_company_social_media_id)

>   UNIQUE KEY ui_mastercompany_socialmedia (master_company_id,social_media_id)

>   KEY fk_master_company_idx (master_company_id)

>   KEY fk_social_meida_idx (social_media_id)

>   KEY fk_mcsm_master_company_source_id (master_company_source_id)

>   KEY fk_mcsm_master_company_social_media_submission_id
>   (master_company_social_media_submission_id)

### FOREIGN KEY on the table:

>   fk_master_company - master_company (master_company_id)

>   fk_mcsm_master_company_social_media_submission_id -
>   master_company_social_media_submission
>   (master_company_social_media_submission_id)

>   fk_mcsm_master_company_source_id - master_company_source
>   (master_company_source_id)

>   fk_social_media - social_media (social_media_id)

*master_company_social_media_submission*
----------------------------------------

### Table Structure:

| **Field**                                 | **Type** | **Null** | **Key** | **Default**       | **Extra**                   |
|-------------------------------------------|----------|----------|---------|-------------------|-----------------------------|
| master_company_social_media_submission_id | int(11)  | NO       | PRI     | NULL              | auto_increment              |
| master_company_id                         | int(11)  | YES      | MUL     | NULL              |                             |
| master_company_source_id                  | int(11)  | YES      | MUL     | NULL              |                             |
| social_media_id                           | int(11)  | YES      | MUL     | NULL              |                             |
| url                                       | text     | YES      |         | NULL              |                             |
| master_company_submission_status_id       | char(1)  | YES      | MUL     | NULL              |                             |
| updater_id                                | int(11)  | YES      |         | NULL              |                             |
| update_time                               | datetime | NO       |         | CURRENT_TIMESTAMP | on update CURRENT_TIMESTAMP |

### INDEX on the table:

>   PRIMARY KEY (master_company_social_media_submission_id)

>   UNIQUE KEY master_company_social_media_submission_udx01
>   (master_company_id,master_company_source_id,social_media_id,master_company_submission_status_id)

>   KEY fk_mcsms_master_company_source_id (master_company_source_id)

>   KEY fk_mcsms_social_media_id (social_media_id)

>   KEY fk_mcsms_master_company_submission_status_id
>   (master_company_submission_status_id)

### FOREIGN KEY on the table:

>   fk_mcsms_master_company_id - master_company (master_company_id)

>   fk_mcsms_master_company_source_id - master_company_source
>   (master_company_source_id)

>   fk_mcsms_master_company_submission_status_id -
>   master_company_submission_status (master_company_submission_status_id)

>   fk_mcsms_social_media_id - social_media (social_media_id)

*master_company_source*
-----------------------

### Table Structure:

| **Field**                | **Type**     | **Null** | **Key** | **Default**       | **Extra**      |
|--------------------------|--------------|----------|---------|-------------------|----------------|
| master_company_source_id | int(11)      | NO       | PRI     | NULL              | auto_increment |
| master_company_source    | varchar(100) | NO       |         | NULL              |                |
| update_time              | datetime     | YES      |         | CURRENT_TIMESTAMP |                |
| active                   | tinyint(4)   | NO       |         | 1                 |                |

### INDEX on the table:

>   PRIMARY KEY (master_company_source_id)

### REFERENCE DATA:

| **master_company_source_id** | **master_company_source** | **update_time**     | **active** |
|------------------------------|---------------------------|---------------------|------------|
| 1                            | Admin                     | 2019-01-15 15:59:07 | 1          |
| 2                            | Recruiter                 | 2019-01-15 15:59:07 | 1          |
| 9                            | Hoovers                   | 2019-01-15 15:59:07 | 1          |
| 10                           | Wikipedia                 | 2019-01-15 15:59:07 | 1          |
| 11                           | Google Finance            | 2019-01-15 15:59:07 | 1          |
| 12                           | S&P                       | 2019-01-15 15:59:07 | 1          |

*master_company_submission_status*
----------------------------------

### Table Structure:

| **Field**                           | **Type**    | **Null** | **Key** | **Default**       | **Extra**                   |
|-------------------------------------|-------------|----------|---------|-------------------|-----------------------------|
| master_company_submission_status_id | char(1)     | NO       | PRI     | NULL              |                             |
| master_company_submission_status    | varchar(16) | NO       |         | NULL              |                             |
| updater_id                          | int(11)     | YES      |         | NULL              |                             |
| update_time                         | datetime    | NO       |         | CURRENT_TIMESTAMP | on update CURRENT_TIMESTAMP |

### INDEX on the table:

>   PRIMARY KEY (master_company_submission_status_id)

### REFERENCE DATA:

| **master_company_submission_status_id** | **master_company_submission_status** | **updater_id** | **update_time**     |
|-----------------------------------------|--------------------------------------|----------------|---------------------|
| A                                       | Approved                             | 0              | 2019-03-18 15:43:06 |
| P                                       | Pending                              | 0              | 2019-03-18 15:43:06 |
| R                                       | Rejected                             | 0              | 2019-03-18 15:43:06 |
