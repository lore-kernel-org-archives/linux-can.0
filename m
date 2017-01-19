From: =?UTF-8?q?Remigiusz=20Ko=C5=82=C5=82=C4=85taj?=
        <remigiusz.kollataj@mobica.com>
Subject: [PATCH v2 0/1] can: mcba_usb: Add support for Microchip CAN BUS Analyzer
Date: Thu, 19 Jan 2017 13:29:48 +0100
Message-ID: <20170119122949.30488-1-remigiusz.kollataj@mobica.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37097 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752434AbdASMaj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Jan 2017 07:30:39 -0500
Received: by mail-wm0-f45.google.com with SMTP id c206so74843557wme.0
        for <linux-can@vger.kernel.org>; Thu, 19 Jan 2017 04:30:39 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: remigiusz.kollataj@mobica.com

Hi,

I have prepared second version of mcba_usb driver. It is based on: 
- [PATCH v3] can: dev: add CAN interface API for fixed bitrates
- [PATCH v5] can: dev: add CAN interface termination API 

To test it I have also updated iproute2 util. You can find it here: https://github.com/rkollataj/iproute2/tree/can_termination_bitrate.

Regards,
Remik

Remigiusz Kołłątaj (1):
  can: mcba_usb: Add support for Microchip CAN BUS Analyzer

 drivers/net/can/usb/Kconfig    |   6 +
 drivers/net/can/usb/Makefile   |   1 +
 drivers/net/can/usb/mcba_usb.c | 911 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 918 insertions(+)
 create mode 100644 drivers/net/can/usb/mcba_usb.c

-- 
2.11.0

