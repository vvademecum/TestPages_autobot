-- MySQL Script generated by MySQL Workbench
-- Thu Mar 24 22:31:58 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


-- -----------------------------------------------------
-- Table `autobot_laravel`.`messages`
-- -----------------------------------------------------

CREATE TABLE `messages` (
  `message_id` VARCHAR(255) NOT NULL,
  `message_text` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`message_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `autobot_laravel`.`telegram_users`
-- -----------------------------------------------------

CREATE TABLE `telegram_users` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `phone_number` VARCHAR(255) NULL DEFAULT NULL,
  `lot_number` VARCHAR(255) NULL DEFAULT NULL,
  `telegram_id` VARCHAR(255) NULL DEFAULT NULL,
  `approved` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `telegram_users_telegram_id_unique` (`telegram_id` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `autobot_laravel`.`reg_cars`
-- -----------------------------------------------------

CREATE TABLE `reg_cars` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `num_car` VARCHAR(255) NOT NULL,
  `add_info` VARCHAR(255) NOT NULL,
  `date_time` DATETIME NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  `full_name` VARCHAR(255) NOT NULL,
  `phone_number` VARCHAR(255) NOT NULL,
  `comment` VARCHAR(255) NOT NULL,
  `status` VARCHAR(255) NOT NULL,
  `approved` INT(11) NOT NULL,
  `telegram_user_id` BIGINT(20) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `reg_cars_telegram_user_id_foreign` (`telegram_user_id` ASC) VISIBLE,
  CONSTRAINT `reg_cars_telegram_user_id_foreign`
    FOREIGN KEY (`telegram_user_id`)
    REFERENCES `telegram_users` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 44
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `autobot_laravel`.`roles`
-- -----------------------------------------------------

CREATE TABLE `roles` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `autobot_laravel`.`users`
-- -----------------------------------------------------


CREATE TABLE `users` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `email_verified_at` TIMESTAMP NULL DEFAULT NULL,
  `password` VARCHAR(255) NOT NULL,
  `remember_token` VARCHAR(100) NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  `role_id` BIGINT(20) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `users_email_unique` (`email` ASC) VISIBLE,
  INDEX `users_role_id_foreign` (`role_id` ASC) VISIBLE,
  CONSTRAINT `users_role_id_foreign`
    FOREIGN KEY (`role_id`)
    REFERENCES `roles` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- -----------------------------------------------------
-- Table `autobot_laravel`.`roles` inserts
-- -----------------------------------------------------
BEGIN;
INSERT INTO roles VALUES(1,'admin');
INSERT INTO roles VALUES(2,'guard');
COMMIT;

-- -----------------------------------------------------
-- Table `autobot_laravel`.`telegram_users` inserts
-- -----------------------------------------------------
BEGIN;
INSERT INTO `telegram_users` VALUES (1, 'Евгений', '79654321111', 'Ул Длинная дом 10 кв 60', '214748364', 1);
INSERT INTO `telegram_users` VALUES (2, 'Васильев Владимир Викторович', '78945612345', 'Ул Длинная дом 12 кв 11', '83523165', 1);
INSERT INTO `telegram_users` VALUES (3, 'Охрана', '79176524509', 'Ул Длинная дом', '111222112', 1);
INSERT INTO `telegram_users` VALUES (4, 'Антон', '89176524508', 'Ул Длинная дом 10 кв 54', '533873224', 1);
INSERT INTO `telegram_users` VALUES (5, 'Фамилия Имя Отчество', '+7 925 507-25-34', '9', '247963948', 0);
COMMIT;

-- -----------------------------------------------------
-- Table `autobot_laravel`.`messages` inserts
-- -----------------------------------------------------
BEGIN;
INSERT INTO `messages` VALUES ('help_message', 'Вас приветствует автоматизированная система заказа пропусков!\nДанная система предназначена для простого заказа пропусков с использованием мессенджера Telegram.\nДля начала работы, необходимо зарегистрироваться в системе. Для регистрации необходимо ввести Фамилию Имя Отчество, номер Вашего телефона и номер участка, на котором Вы проживаете.\n\nНапример:\nИванов Иван Иванович, 89161234567, 777\n\nПосле подтверждения Администратором Вашей регистрации, Вам поступит соответствующее сообщение, после которого Вы сможете заказывать пропуска для машин Ваших гостей для въезда на территорию посёлка.\n');
INSERT INTO `messages` VALUES ('start_hello_message', 'Вас приветствует БОТ заказа пропусков!\nДля начала, необходимо зарегистрироваться в системе.\nДля этого введите ФИО, номер телефона и номер участка (через запятую): ');
INSERT INTO `messages` VALUES ('start_hello_messageFor', 'Здравствуйте,  %s\nВас приветствует БОТ заказа пропусков!');
INSERT INTO `messages` VALUES ('start_confirmReg_message', 'Пожалуйста, дождитесь подтверждения регистрации!');
INSERT INTO `messages` VALUES ('start_ban_message', 'К сожалению, Вы временно не можете использовать систему заказа пропусков!');
INSERT INTO `messages` VALUES ('start_regIsConfirmed_message', 'Для заказа пропуска ввердите номер и марку машины!');
INSERT INTO `messages` VALUES ('error_checkPhone_message', 'Неправильно введён номер телефона.\nВведите ФИО, номер телефона и номер участка (через запятую):');
INSERT INTO `messages` VALUES ('error_checkSector_message', 'Неправильно введён номер участка.\nВведите ФИО, номер телефона и номер участка (через запятую):');
INSERT INTO `messages` VALUES ('error_checkName_message', 'Неправильно введены ФИО.\nВведите ФИО, номер телефона и номер участка (через запятую):');
INSERT INTO `messages` VALUES ('regIsCompleted_message', 'ФИО: %s\nТелефон: %s\nНомер участка: %s\n\nРегистрация завершена, ожидайте подтверждения учётной записи');
INSERT INTO `messages` VALUES ('error_reg_message', 'Ошибка регистрации, попробуйте повторить попытку позднее');
INSERT INTO `messages` VALUES ('error_repeatReg_message', 'Неправильный ввод\nВведите ФИО, номер телефона и номер участка (через запятую):');
INSERT INTO `messages` VALUES ('error_checkCarNum_message', 'Неправильно введён номер автомобиля');
INSERT INTO `messages` VALUES ('requestIsCompleted_message', 'Номер: %s\nМарка: %s\n\nЗаявка принята');
INSERT INTO `messages` VALUES ('error_repeatRequest', 'Неправильный ввод\nДля заказа пропуска ввердите номер и марку машины!');
COMMIT;

-- -----------------------------------------------------
-- Table `autobot_laravel`.`reg_cars` inserts
-- -----------------------------------------------------
BEGIN;
INSERT INTO `reg_cars` VALUES (27, 'П100ПВ', 'Синяя машина', '2021-12-21 00:32:00', 'фывфывфывфыв', 'Серый Сергей Сергеевич', 78945612345, 'Я хочу заехать', 'Завершена', 0, 1);
INSERT INTO `reg_cars` VALUES (28, 'П100ПП', 'Зеленая машина', '2021-12-21 00:32:00', 'фывфывфывфыв', 'Серый Сергей Сергеевич', 78945612345, 'Я хочу заехать', 'Завершена', 0, 1);
INSERT INTO `reg_cars` VALUES (30, 'A123AA', 'фывфывфы', '2022-01-21 11:12:00', 'фывфывфыв', 'Иванова Иван Иванович', 78945612345, ' Я хочу заехать', 'Завершена', 0, 2);
INSERT INTO `reg_cars` VALUES (32, 'A123AA', 'Синяя машина', '2022-01-21 11:13:00', 'fghfhkjkj', 'Серый Сергей Сергеевич', 79812311223, ' sdfgsdfg', 'На парковке', 0, 2);
INSERT INTO `reg_cars` VALUES (33, 'П100КК', 'Красная машина', '2022-01-25 07:16:00', 'rsdfgh', 'Серый Сергей Сергеевич', 79812311223, ' Я хочу заехать', 'Ожидается', 0, 2);
INSERT INTO `reg_cars` VALUES (35, 'П100ПП', 'Красная машина', '2022-01-24 23:19:00', 'ваыпываыва', 'Серый Сергей Сергеевич', 79812311223, ' Я хочу заехать', 'На парковке', 0, 3);
INSERT INTO `reg_cars` VALUES (36, 'П100ПП', 'Синяя машина', '2022-01-23 23:21:00', 'ыфв', 'Иванова Иван Иванович', 79812311223, ' Я хочу заехать', 'Завершена', 0, 3);
INSERT INTO `reg_cars` VALUES (37, 'П100ПП', '', '2022-01-23 23:23:00', '', 'Валерий Иванов Валерьевич', 0, '', 'Завершена', 0, 3);
INSERT INTO `reg_cars` VALUES (38, 'ASDAS123', '', '2022-01-13 00:53:00', '', 'Валерий Иванов Валерьевич', 0, '', 'Завершена', 0, 4);
INSERT INTO `reg_cars` VALUES (39, 'asdas', 'Синяя машина', '2022-01-26 06:15:00', 'фывфыв', 'Иванова Иван Иванович', 79812311223, ' ', 'Ожидается', 0, 5);
INSERT INTO `reg_cars` VALUES (40, 'A123AA', '', '2022-01-02 01:04:00', '', 'Валерий Иванов Валерьевич', 0, '', 'Отменена', 0, 4);
INSERT INTO `reg_cars` VALUES (41, 'A123AA', '', '2022-01-25 05:41:00', '', 'Валерий Иванов Валерьевич', 0, '', 'Отменена', 0, 5);
INSERT INTO `reg_cars` VALUES (42, 'фывфыв', '', '2022-01-28 05:46:00', '', 'Сергей', 0, '', 'Отменена', 0, 5);
INSERT INTO `reg_cars` VALUES (43, 'П100ПП', 'Синяя машина', '2022-01-25 06:21:00', 'Csaqwsad', 'Серый Сергей Сергеевич', 99999999999, ' ', 'Ожидается', 0, 4);
COMMIT;