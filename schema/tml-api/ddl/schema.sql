USE tml;


CREATE TABLE IF NOT EXISTS `pickup_point` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(100) NOT NULL COMMENT 'pickup point company  or individual''s name',
    `address_line_1` varchar(100) DEFAULT NULL COMMENT 'pickup point address line 1',
    `address_line_2` varchar(100) DEFAULT NULL COMMENT 'pickup point address line 2',
    `address_line_3` varchar(100) DEFAULT NULL COMMENT 'pickup point address line 3',
    `surburb` varchar(100) DEFAULT NULL COMMENT 'pickup point location surburb',
    `city` varchar(100) DEFAULT NULL COMMENT 'pickup point location city',
    `country` varchar(100) DEFAULT NULL COMMENT 'pickup point location country',
    `latitude` varchar(100) DEFAULT NULL COMMENT 'pickup point location latitude',
    `longitude` varchar(100) DEFAULT NULL COMMENT 'pickup point location longitude',
    `email_address` varchar(100) DEFAULT NULL COMMENT 'pickup point email address',
    `phone_number_1` varchar(30) NOT NULL COMMENT 'pickup point main phone number',
    `phone_number_2` varchar(30) DEFAULT NULL COMMENT 'pickup point secondary phone number',
    `office_hours` varchar(15) NOT NULL COMMENT 'office hours pickup point is open',
    `created_at` datetime(6) NOT NULL COMMENT 'date pickup point created',
    `updated_at` datetime(6) NOT NULL COMMENT 'date pickup point updated',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;


CREATE TABLE IF NOT EXISTS `category` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(200) NOT NULL COMMENT 'category name',
    `slug` varchar(50) NOT NULL COMMENT 'category slug',
    `help_text` varchar(200) NOT NULL COMMENT 'help text',
    `description` longtext NOT NULL COMMENT 'category long description',
    `meta_keywords` varchar(255) NOT NULL COMMENT 'meta keywords',
    `is_active` tinyint(1) NOT NULL COMMENT 'is category active?',
    `created_at` datetime(6) NOT NULL COMMENT 'date category created',
    `updated_at` datetime(6) NOT NULL COMMENT 'date category updated',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uq_category_slug` (`slug`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;


CREATE TABLE IF NOT EXISTS `product` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL COMMENT 'product display name',
    `slug` varchar(255) NOT NULL COMMENT 'Unique value for product page URL, created from name.',
    `brand` varchar(50) NOT NULL COMMENT 'product brand',
    `sku` varchar(50) NOT NULL COMMENT 'product sku',
    `price` decimal(9, 2) NOT NULL COMMENT 'product price',
    `old_price` decimal(9, 2) NOT NULL,
    `image` varchar(100) NOT NULL COMMENT 'product image',
    `thumbnail` varchar(100) NOT NULL COMMENT 'product thumbnail',
    `image_caption` varchar(200) NOT NULL COMMENT 'product image caption',
    `is_active` tinyint(1) NOT NULL COMMENT 'is the product active',
    `is_featured` tinyint(1) NOT NULL COMMENT 'is the product featured',
    `units` int(11) NOT NULL DEFAULT '1' COMMENT 'number of units in product',
    `volume` int(11) NOT NULL COMMENT 'product volume',
    `volume_unit` varchar(50) NOT NULL COMMENT 'product volume unit e.g. ml, kg',
    `description` longtext NOT NULL COMMENT 'product long description',
    `meta_keywords` varchar(255) NOT NULL COMMENT 'Comma-delimited set of SEO keywords for meta tag',
    `meta_description` varchar(255) NOT NULL COMMENT 'Content for description meta tag',
    `created_at` datetime(6) NOT NULL COMMENT 'date product created',
    `updated_at` datetime(6) NOT NULL COMMENT 'date product updated',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uq_product_name` (`name`),
    UNIQUE KEY `uq_product_slug` (`slug`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;


CREATE TABLE IF NOT EXISTS `category_products` (
    `category_id` int(11) NOT NULL COMMENT 'category id',
    `product_id` int(11) NOT NULL COMMENT 'product id',
    PRIMARY KEY (`category_id`, `product_id`),
    KEY `fk_category_products_product_id_product` (`product_id`),
    CONSTRAINT `fk_category_products_category_id_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_category_products_product_id_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8;


CREATE TABLE IF NOT EXISTS `hamper` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL COMMENT 'hamper name',
    `slug` varchar(255) NOT NULL COMMENT 'hamper slug',
    `image` varchar(100) NOT NULL COMMENT 'hamper image',
    `thumbnail` varchar(100) NOT NULL COMMENT 'hamper thumbnail',
    `is_active` tinyint(1) NOT NULL COMMENT 'is hamper active ?',
    `is_featured` tinyint(1) NOT NULL COMMENT 'is hamper featured ?',
    `description` longtext NOT NULL COMMENT 'hamper description',
    `created_at` datetime(6) NOT NULL COMMENT 'date hamper created',
    `updated_at` datetime(6) NOT NULL COMMENT 'date hamper updated',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uq_hamper_name` (`name`),
    UNIQUE KEY `uq_hamper_slug` (`slug`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;


CREATE TABLE IF NOT EXISTS `hamper_products` (
    `hamper_id` int(11) NOT NULL COMMENT 'hamper id',
    `product_id` int(11) NOT NULL COMMENT 'product id',
    `quantity` int(11) NOT NULL COMMENT 'quantity of products in hamper',
    PRIMARY KEY (`hamper_id`, `product_id`),
    KEY `ix_hamper_products_hamper_id` (`hamper_id`),
    KEY `ix_hamper_products_product_id` (`product_id`),
    CONSTRAINT `fk_hamper_products_hamper_id_hamper` FOREIGN KEY (`hamper_id`) REFERENCES `hamper` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_hamper_products_product_id_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8;


CREATE TABLE IF NOT EXISTS `user` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `first_name` varchar(30) NOT NULL COMMENT 'user first name',
    `last_name` varchar(150) NOT NULL COMMENT 'user last name',
    `password_hash` varchar(128) NOT NULL COMMENT 'password hash',
    `last_login` datetime(6) DEFAULT NULL COMMENT 'date of last login',
    `is_super_user` tinyint(1) NOT NULL COMMENT 'is super user?',
    `user_name` varchar(150) NOT NULL COMMENT 'user name',
    `email_address` varchar(320) NOT NULL COMMENT 'user email',
    `uuid` varchar(100) NOT NULL COMMENT 'user email',
    `is_staff` tinyint(1) NOT NULL COMMENT 'is staff?',
    `is_active` tinyint(1) NOT NULL COMMENT 'is user active?',
    `date_joined` datetime(6) NOT NULL COMMENT 'date user joined thumela platform',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uq_user_user_name` (`user_name`),
    UNIQUE KEY `uq_user_email_address` (`email_address`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;


CREATE TABLE IF NOT EXISTS `cart_item` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `quantity` int(11) NOT NULL,
    `cart_id` varchar(100) NOT NULL COMMENT 'cart id',
    `product_id` int(11) NOT NULL,
    `date_added` datetime(6) NOT NULL,
    PRIMARY KEY (`id`),
    KEY `ix_cart_item_product_id` (`product_id`),
    CONSTRAINT `fk_cart_item_product_id_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8;


CREATE TABLE IF NOT EXISTS `search` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `q` varchar(50) NOT NULL COMMENT 'search term',
    `search_date` datetime(6) NOT NULL COMMENT 'date search performed',
    `ip_address` char(39) NOT NULL COMMENT 'user ip address',
    `category_id` int(11) DEFAULT NULL COMMENT 'category id',
    `user_id` int(11) DEFAULT NULL COMMENT 'user id',
    PRIMARY KEY (`id`),
    KEY `ix_search_category_id` (`category_id`),
    KEY `ix_search_user_id` (`user_id`),
    CONSTRAINT `fk_search_category_id_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_search_user_id_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8;


CREATE TABLE IF NOT EXISTS `courier` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `company_name` varchar(100) NOT NULL COMMENT 'courier company  or individual''s name',
    `email_address` varchar(100) NOT NULL COMMENT 'courier email address',
    `phone_number_1` varchar(30) NOT NULL COMMENT 'courier main phone number',
    `phone_number_2` varchar(30) DEFAULT NULL COMMENT 'courier secondary phone number',
    `address_line_1` varchar(100) DEFAULT NULL COMMENT 'courier address line 1',
    `address_line_2` varchar(100) DEFAULT NULL COMMENT 'courier address line 2',
    `address_line_3` varchar(100) DEFAULT NULL COMMENT 'courier address line 3',
    `surburb` varchar(100) DEFAULT NULL COMMENT 'courier location surburb',
    `city` varchar(100) DEFAULT NULL COMMENT 'courier location city',
    `country` varchar(100) DEFAULT NULL COMMENT 'courier location country',
    `account_name` varchar(15) DEFAULT NULL COMMENT 'account name',
    `account_number` varchar(15) DEFAULT NULL COMMENT 'account number',
    `branch_name` varchar(15) DEFAULT NULL COMMENT 'branch name',
    `branch_code` varchar(15) DEFAULT NULL COMMENT 'branch code',
    `bank_name` varchar(15) DEFAULT NULL COMMENT 'bank name',
    `currency` varchar(15) DEFAULT NULL COMMENT 'account currency',
    `account_country` varchar(15) DEFAULT NULL COMMENT 'country where bank is located',
    `created_at` datetime(6) NOT NULL COMMENT 'date courier created',
    `updated_at` datetime(6) NOT NULL COMMENT 'date courier updated',
    `user_id` int(11) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uq_courier_user_id` (`user_id`),
    CONSTRAINT `fk_courier_user_id_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8;


CREATE TABLE IF NOT EXISTS `recipient` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `first_name` varchar(100) NOT NULL COMMENT 'recipient first name',
    `last_name` varchar(100) NOT NULL COMMENT 'recipient last name',
    `id_number` varchar(100) NOT NULL COMMENT 'recipient id number',
    `email_address` varchar(100) DEFAULT NULL COMMENT 'recipient email address',
    `phone_number_1` varchar(30) NOT NULL COMMENT 'recipient main phone number',
    `phone_number_2` varchar(30) DEFAULT NULL COMMENT 'recipient secondary phone number',
    `address_line_1` varchar(100) DEFAULT NULL COMMENT 'recipient address line 1',
    `address_line_2` varchar(100) DEFAULT NULL COMMENT 'recipient address line 2',
    `address_line_3` varchar(100) DEFAULT NULL COMMENT 'recipient address line 3',
    `surburb` varchar(100) DEFAULT NULL COMMENT 'recipient location surburb',
    `city` varchar(100) DEFAULT NULL COMMENT 'recipient location city',
    `country` varchar(100) DEFAULT NULL COMMENT 'recipient location country',
    `latitude` varchar(100) DEFAULT NULL COMMENT 'recipient location latitude',
    `longitude` varchar(100) DEFAULT NULL COMMENT 'recipient location longitude',
    `created_at` datetime(6) NOT NULL COMMENT 'date recipient created',
    `updated_at` datetime(6) NOT NULL COMMENT 'date recipient created',
    `user_id` int(11) NOT NULL COMMENT 'user id',
    PRIMARY KEY (`id`),
    KEY `fk_recipient_user_id_user` (`user_id`),
    CONSTRAINT `fk_recipient_user_id_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8;



CREATE TABLE IF NOT EXISTS `supplier` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `company_name` varchar(100) NOT NULL COMMENT 'supplier company or individual''s name',
    `email_address` varchar(100) NOT NULL COMMENT 'supplier email address',
    `phone_number_1` varchar(30) NOT NULL COMMENT 'supplier main phone number',
    `phone_number_2` varchar(30) DEFAULT NULL COMMENT 'supplier secondary phone number',
    `address_line_1` varchar(100) DEFAULT NULL COMMENT 'supplier address line 1',
    `address_line_2` varchar(100) DEFAULT NULL COMMENT 'supplier address line 2',
    `address_line_3` varchar(100) DEFAULT NULL COMMENT 'supplier address line 3',
    `surburb` varchar(100) DEFAULT NULL COMMENT 'supplier location surburb',
    `city` varchar(100) DEFAULT NULL COMMENT 'supplier location city',
    `country` varchar(100) DEFAULT NULL COMMENT 'supplier location country',
    `account_name` varchar(15) DEFAULT NULL COMMENT 'account name',
    `account_number` varchar(15) DEFAULT NULL COMMENT 'account number',
    `branch_name` varchar(15) DEFAULT NULL COMMENT 'branch name',
    `branch_code` varchar(15) DEFAULT NULL COMMENT 'branch code',
    `bank_name` varchar(15) DEFAULT NULL COMMENT 'bank name',
    `currency` varchar(15) DEFAULT NULL COMMENT 'account currency',
    `account_country` varchar(15) DEFAULT NULL COMMENT 'country where bank is located',
    `created_at` datetime(6) NOT NULL COMMENT 'date supplier created',
    `updated_at` datetime(6) NOT NULL COMMENT 'date supplier updated',
    `user_id` int(11) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uq_supplier_user_id` (`user_id`),
    CONSTRAINT `fk_supplier_user_id_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8;


CREATE TABLE IF NOT EXISTS `order` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `state` varchar(20) NOT NULL COMMENT 'order state',
    `date_created` datetime(6) NOT NULL COMMENT 'date order created',
    `delivery_method` varchar(100) NOT NULL COMMENT 'selected delivery method for order',
    `security_question` varchar(100) DEFAULT NULL COMMENT 'collection security question at pickup point',
    `security_answer` varchar(100) DEFAULT NULL COMMENT 'collection security answer',
    `created_at` datetime(6) NOT NULL COMMENT 'date order created',
    `updated_at` datetime(6) NOT NULL COMMENT 'date order updated',
    `pick_up_point_id` int(11) DEFAULT NULL COMMENT 'pickup point',
    `recipient_id` int(11) DEFAULT NULL COMMENT 'recipient',
    `supplier_id` int(11) DEFAULT NULL COMMENT 'supplier',
    `user_id` int(11) DEFAULT NULL COMMENT 'user who placed the order',
    PRIMARY KEY (`id`),
    KEY `ix_order_pick_up_point_id` (`pick_up_point_id`),
    KEY `ix_order_recipient_id` (`recipient_id`),
    KEY `ix_order_user_id` (`user_id`),
    KEY `ix_order_supplier_id` (`supplier_id`),
    CONSTRAINT `fk_order_pick_up_point_id_pickup_point` FOREIGN KEY (`pick_up_point_id`) REFERENCES `pickup_point` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_order_recipient_id_recipient` FOREIGN KEY (`recipient_id`) REFERENCES `recipient` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_order_supplier_id_supplier` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_order_user_id_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8;


CREATE TABLE IF NOT EXISTS `order_item` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `date_added` datetime(6) NOT NULL,
    `quantity` int(11) NOT NULL COMMENT 'quantity of product in order',
    `unit_price` decimal(9, 2) NOT NULL COMMENT 'unit price pf product at time of order creation',
    `order_id` int(11) NOT NULL COMMENT 'order id',
    `product_id` int(11) NOT NULL COMMENT 'product id',
    PRIMARY KEY (`id`),
    KEY `ix_order_item_product_id` (`product_id`),
    KEY `ix_order_item_order_id` (`order_id`),
    CONSTRAINT `fk_order_item_order_id_order` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_order_item_product_id_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8;


CREATE TABLE IF NOT EXISTS `payment_completion` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `pay_request_id` varchar(36) NOT NULL COMMENT 'the PAY_REQUEST_ID returned by PayWeb in the Initiate',
    `transaction_status` smallint(6) NOT NULL COMMENT 'The final status of the transaction.',
    `checksum` varchar(32) NOT NULL COMMENT 'This field contains a calculated MD5 hash based on the values of the PAYGATE_ID, PAY_REQUEST_ID, TRANSACTION_STATUS, REFERENCE',
    `raw_response` longtext NOT NULL COMMENT 'Raw response sent from Paygate',
    `created_at` datetime(6) NOT NULL COMMENT 'date payment completion created',
    `updated_at` datetime(6) NOT NULL COMMENT 'date payment completion updated',
    `order_id` int(11) NOT NULL COMMENT 'order id',
    PRIMARY KEY (`id`),
    KEY `ix_payment_completion_order_id` (`order_id`),
    CONSTRAINT `fk_payment_completion_order_id_order` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8;


CREATE TABLE IF NOT EXISTS `payment_initiation` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `paygate_id` varchar(20) NOT NULL COMMENT 'the id assigned by Paygate',
    `reference` varchar(110) NOT NULL COMMENT 'our internal reference - order id',
    `amount` varchar(20) NOT NULL COMMENT 'transaction amount in cents. e.g. 32.99 is specified as 3299',
    `currency` varchar(5) NOT NULL COMMENT 'currency code of the currency the customer is paying in. (Refer to Currency Codes)',
    `return_url` varchar(255) NOT NULL COMMENT 'payweb will return the customer to a page specified in this field once the transaction is completed',
    `transaction_date` datetime(6) NOT NULL COMMENT 'the date that the transaction was initiated on your website or system specified in coordinated universal time (utc) e.g. 2016-05-30 09:30:10 datetime',
    `locale` varchar(5) NOT NULL COMMENT 'the locale code identifies to Paygate the customer’s language, country and any special variant preferences Paygate will default to the en locale',
    `country` varchar(5) NOT NULL COMMENT 'code of the country the customer is paying from. refer to country codes',
    `email` varchar(254) NOT NULL COMMENT 'if the transaction is approved, payweb will email a payment confirmation to this email address(set up on portal)',
    `pay_method` varchar(2) NOT NULL COMMENT 'payment method customer requests',
    `pay_method_detail` varchar(45) NOT NULL COMMENT 'field should be left blank unless the merchant has more than one active payment method and wants to make sure that the client is presented with a specific payment method',
    `notify_url` varchar(110) NOT NULL COMMENT 'If the notify URL field is populated, then PayWeb will post the fields as specified in the Response table to the notify URL immediately when the transaction is completed',
    `user_1` varchar(255) NOT NULL COMMENT 'this field is optional and has been included as a placeholder for merchant specific requirements',
    `user_2` varchar(255) NOT NULL COMMENT 'this field is optional and has been included as a placeholder for merchant specific requirements',
    `user_3` varchar(255) NOT NULL COMMENT 'this field is optional and has been included as a placeholder for merchant specific requirements',
    `vault` smallint(6) NOT NULL COMMENT 'This field is optional but should only be included if PayVault credit card tokenisation is enabled on the merchant profile',
    `vault_id` varchar(40) NOT NULL COMMENT 'This field is optional and should only be included if PayVault credit card tokenisation is enabled',
    `request_checksum` varchar(110) DEFAULT NULL COMMENT 'This field contains a calculated MD5 hash based on the values of ALL the above-mentioned fields and a key',
    `raw_request` longtext NOT NULL COMMENT 'Raw request sent to Paygate',
    `raw_response` longtext NOT NULL COMMENT 'Raw response sent to Paygate',
    `order_id` int(11) NOT NULL COMMENT 'order id',
    `pay_request_id` varchar(40) DEFAULT NULL COMMENT 'This field is optional and should only be included if a succesful response is recieved for payment initiation',
    `response_checksum` varchar(110) DEFAULT NULL COMMENT 'This field contains a calculated MD5 hash returned by Paygate',
    `created_at` datetime(6) NOT NULL COMMENT 'date payment initiation created',
    `updated_at` datetime(6) NOT NULL COMMENT 'date payment initiation updated',
    PRIMARY KEY (`id`),
    KEY `ix_payment_initiation_order_id` (`order_id`),
    CONSTRAINT `fk_payment_initiation_order_id_order` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8;


CREATE TABLE IF NOT EXISTS `payment_notification` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `paygate_id` varchar(110) NOT NULL COMMENT 'This should be the same Paygate ID that was passed in the request; if it is not, then the data has been altered.',
    `pay_request_id` varchar(36) NOT NULL COMMENT 'The PAY_REQUEST_ID returned by PayWeb in the initiate',
    `reference` varchar(110) NOT NULL COMMENT 'This should be the same reference that was passed in the request; if it is not, then the data has been altered.',
    `transaction_status` smallint(6) NOT NULL COMMENT 'The final status of the transaction',
    `result_code` int(11) NOT NULL COMMENT 'This field contains a code indicating the result of the transaction',
    `auth_code` varchar(10) NOT NULL COMMENT 'If the bank or financial institution approves the transaction, then the authorisation code will be placed in this field. For non-card payment methods, this field is populated with 999999',
    `currency` varchar(5) NOT NULL COMMENT 'currency code of the currency the customer is paying in',
    `amount` varchar(11) NOT NULL COMMENT 'this should be the same amount that was passed in the request. If it is not, then the data has been altered.',
    `result_desc` varchar(100) NOT NULL COMMENT 'This field contains a description for the result of the transaction.',
    `transaction_id` varchar(11) NOT NULL,
    `risk_indicator` varchar(2) NOT NULL COMMENT 'This is a 2-character field containing a risk indicator for this transaction',
    `pay_method` varchar(2) NOT NULL COMMENT 'This field contains a code describing/confirming the payment method used to process the transaction.',
    `pay_method_detail` varchar(110) NOT NULL COMMENT 'This field may contain a description of the PAY_METHOD code',
    `user_1` varchar(255) DEFAULT NULL COMMENT 'this field is optional and has been included as a placeholder for merchant specific requirements',
    `user_2` varchar(255) DEFAULT NULL COMMENT 'this field is optional and has been included as a placeholder for merchant specific requirements',
    `user_3` varchar(255) DEFAULT NULL COMMENT 'this field is optional and has been included as a placeholder for merchant specific requirements',
    `vault_id` varchar(40) DEFAULT NULL,
    `pay_vault_data_1` varchar(50) DEFAULT NULL COMMENT 'This field contains information on the credit card or e-wallet account linked to the PayVault token for managing the use of the token',
    `pay_vault_data_2` varchar(50) DEFAULT NULL COMMENT 'This field contains information on the credit card or e-wallet account linked to the PayVault token for managing the use of the token.',
    `checksum` varchar(110) NOT NULL COMMENT 'This field contains a calculated MD5 hash based on the values of ALL the above-mentioned fields and a key',
    `raw_response` longtext NOT NULL COMMENT 'Raw response sent to Paygate',
    `created_at` datetime(6) NOT NULL COMMENT 'date payment notification created',
    `updated_at` datetime(6) NOT NULL COMMENT 'date payment notification updated',
    `order_id` int(11) NOT NULL,
    PRIMARY KEY (`id`),
    KEY `ix_payment_notification_order_id` (`order_id`),
    CONSTRAINT `fk_payment_notification_order_id_order` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8;
