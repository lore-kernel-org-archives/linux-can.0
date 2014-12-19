From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH 0/5] can-utils: slcand: minor fixes and udev scripts
Date: Fri, 19 Dec 2014 07:22:15 -0800
Message-ID: <1419002540-2208-1-git-send-email-jmmahler@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:59567 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416AbaLSPWv (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 19 Dec 2014 10:22:51 -0500
Received: by mail-pa0-f51.google.com with SMTP id ey11so1393962pad.10
        for <linux-can@vger.kernel.org>; Fri, 19 Dec 2014 07:22:50 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>

This is a set of minor fixes to slcand that I made while setting up
slcand with a USB CAN device.  I also added configuration files for
udev/systemd to automatically start/stop slcand when the usb serial
device is plugged in.

It is based off the master branch of can-utils.

  https://gitorious.org/linux-can/can-utils.git

Jeremiah Mahler (5):
  slcand: improve usage examples
  slcand: remove #define EXIT_FAILURE, EXIT_SUCCESS
  slcand: consistent use of exit(EXIT_FAILURE)
  use line discipline number from linux/tty.h
  slcand: add example scripts for udev/systemd

 doc/50-slcand.rules | 16 ++++++++++++++++
 doc/slcand@.service | 11 +++++++++++
 slcan_attach.c      |  5 ++---
 slcand.c            | 20 ++++++++------------
 4 files changed, 37 insertions(+), 15 deletions(-)
 create mode 100644 doc/50-slcand.rules
 create mode 100644 doc/slcand@.service

-- 
2.1.3

