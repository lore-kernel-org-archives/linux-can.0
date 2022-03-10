Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AFFC433EF
	for <linux-can@archiver.kernel.org>; Thu, 10 Mar 2022 09:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238397AbiCJKAH (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 10 Mar 2022 05:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238273AbiCJKAF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 10 Mar 2022 05:00:05 -0500
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984B7107D99
        for <linux-can@vger.kernel.org>; Thu, 10 Mar 2022 01:59:00 -0800 (PST)
Received: from localhost.localdomain (unknown [89.158.146.116])
        (Authenticated sender: stephane.grosjean@free.fr)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id B4FC82003B4;
        Thu, 10 Mar 2022 10:58:57 +0100 (CET)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 0/8 v3] can: peak_usb: value net dev_port field from flash memory
Date:   Thu, 10 Mar 2022 10:58:33 +0100
Message-Id: <20220310095841.9134-1-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The field "struct net_device::dev_port" (exported under sysfs) is used to
differentiate between the interfaces of a device. This series of patches
allows the user to value this field from a value read from the flash memory
of the CAN-USB interfaces of PEAK-System GmbH by implementing the ethtool
interface which offers read/write access to the eeprom of the device:

$ ethtool -E can0 value 3
$ ethtool -e can0
Offset		Values
------		------
0x0000:		03 00 00 00 
$ cat /sys/class/net/can0/dev_port
3

Uniquely identifying the CAN interface of a USB device allows it to be
connected to any USB port on the host machine, in any order.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>

Stephane Grosjean (8):
  can: peak_usb: rename a callback to a more explicit name
  can: peak_usb: add callback to read user value of CANFD devices
  can: peak_usb: correction of a wrong field name
  can: peak_usb: switch function parameter to native format
  can: peak_usb: allow flashing of user defined value
  can: peak_usb: add ethtool interface to user defined flashed device
    number
  can: peak_usb: replace device_number priv field with netdev dev_port
    field
  can: peak_usb: replace unregister_netdev() with unregister_candev()

 drivers/net/can/usb/peak_usb/pcan_usb.c      | 39 +++++++++--
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 74 ++++++++++++++++++--
 drivers/net/can/usb/peak_usb/pcan_usb_core.h | 10 ++-
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   | 56 ++++++++++++++-
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  | 27 +++++--
 drivers/net/can/usb/peak_usb/pcan_usb_pro.h  |  3 +-
 6 files changed, 192 insertions(+), 17 deletions(-)

-- 
2.25.1

