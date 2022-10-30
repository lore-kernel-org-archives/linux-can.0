Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDC7FA3740
	for <linux-can@archiver.kernel.org>; Sun, 30 Oct 2022 11:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJ3LBC (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Sun, 30 Oct 2022 07:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJ3LBB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 30 Oct 2022 07:01:01 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A85314
        for <linux-can@vger.kernel.org>; Sun, 30 Oct 2022 04:01:00 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 4B41024002A
        for <linux-can@vger.kernel.org>; Sun, 30 Oct 2022 12:00:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1667127659; bh=gCldh0ajoLi5UVKCHz6p5X0kuS8tHM5gMjtLkjgvbK4=;
        h=From:To:Subject:Date:From;
        b=CLbWfoM7kAdx3jEoktFxjwb3ADcBYab0glJpeesgVCm7lPagDPvRCypZfGKbxmylC
         B8DTZXIipaEBja7YnZjOqL+7P7i32NEkh+gtT0HpMkCr+WX4EeIXu5JRzGPHIMGs0v
         AdOOAlmAAeStoL9BEfePNo3B0MboGW2KslInDaxCVC8PWyKr4C3hSS4BTrgdzz9K49
         XSUAfL+hsSwqViyTekywHpSvQhqKr8pLiZch8EKk49qK+ikOiUQrKV60Rt37QL0FmM
         W4CKsrGZkq6mmjIsi2oSjhFhwFw7zAp3boLo0nuFfocOKG5d4qNOtn5FaU1QUepG+6
         hyRsygPH1E0Vw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4N0YHG6FWPz9rxK
        for <linux-can@vger.kernel.org>; Sun, 30 Oct 2022 12:00:58 +0100 (CET)
From:   Lukas Magel <lukas.magel@posteo.net>
To:     linux-can@vger.kernel.org
Subject: [PATCH v2 0/7] can: peak_usb: Introduce configurable user dev id
Date:   Sun, 30 Oct 2022 10:59:32 +0000
Message-Id: <20221030105939.87658-1-lukas.magel@posteo.net>
In-Reply-To: <20220801080446.36374-1-lukas.magel@posteo.net>
References: <20220801080446.36374-1-lukas.magel@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This series of patches introduces the user device id for the PEAK USB
CAN interfaces. The id can be read/written via ethtool and is exposed as
a read-only attribute via sysfs. This allows users to set the id via
ethtool and write udev rules to match against the sysfs attribute.

Most of the patches were originally introduced by Stéphane Grosjean and
have only been modified slightly. See the following threads for the
original patches:

* https://lore.kernel.org/linux-can/20220128150157.1222850-1-s.grosjean@peak-system.com/T/#mad8014c9f1c89a50d5944a50ae0a585edec79eab
* https://lore.kernel.org/linux-can/20211117150132.37056-1-s.grosjean@peak-system.com/T/#mbf1d7db8433734a1fe08868d79f9927a04fe7ffe

v2:
* Fix type of devid_le in ethtool peak_usb_(get|set)_eeprom
* Fix signed-off tags

Stéphane Grosjean (5):
  can: peak_usb: rename device_id to a more explicit name
  can: peak_usb: add callback to read user value of CANFD
  can: peak_usb: allow flashing of the user device id
  can: peak_usb: replace unregister_netdev() with
  can: peak_usb: add ethtool interface to user defined

Lukas Magel (2):
  can: peak_usb: export PCAN user device ID as sysfs device
  can: peak_usb: align user device id format in log with

.../ABI/testing/sysfs-class-net-peak_usb        |  15 +++
drivers/net/can/usb/peak_usb/pcan_usb.c         |  43 ++++++-
drivers/net/can/usb/peak_usb/pcan_usb_core.c    | 119 +++++++++++++++++--
drivers/net/can/usb/peak_usb/pcan_usb_core.h    |  11 +-
drivers/net/can/usb/peak_usb/pcan_usb_fd.c      |  64 +++++++++-
drivers/net/can/usb/peak_usb/pcan_usb_pro.c     |  26 +++-
drivers/net/can/usb/peak_usb/pcan_usb_pro.h     |   1 +
7 files changed, 254 insertions(+), 25 deletions(-)

---
@Marc: Thanks for the feedback. I naively left out my tag because I
hadn't modified patch 5. I should have reread the kernel doc on the tags
first.

