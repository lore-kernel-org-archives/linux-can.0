From: =?UTF-8?Q?Janusz_U=c5=bcycki?= <j.uzycki@elpromaelectronics.com>
Subject: bug in DT docs vs mcp251x.c driver
Date: Tue, 21 Feb 2017 19:08:16 +0100
Message-ID: <1d36bb5b-b46a-8e9a-672b-907cac5c5ab4@elpromaelectronics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from cloudserver032797.home.net.pl ([89.161.177.31]:58979 "EHLO
        cloudserver032797.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753268AbdBUSPE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 21 Feb 2017 13:15:04 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "l.dalek elpromaelectronics.com" <l.dalek@elpromaelectronics.com>

Hi,

We've noticed the inconsistency in DT which still exist in kernel v4.10:

devm_regulator_get(&spi->dev, "vdd") in drivers/net/can/mcp251x.c

vs vdd-supply: Regulator that powers the CAN controller. in
bindings/net/can/microchip,mcp251x.txt
Eg. https://patchwork.ozlabs.org/patch/304371/ best regards Janusz 
Użycki ELPROMA

