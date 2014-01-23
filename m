From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: slcand: tty device name
Date: Thu, 23 Jan 2014 08:21:19 +0100
Message-ID: <CAGm1_ks=hrhb4WTs9jiqgViYOmAAC+dnLCc5LpXP8TWMe65Yrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49]:50831 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbaAWHVk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 23 Jan 2014 02:21:40 -0500
Received: by mail-bk0-f49.google.com with SMTP id v15so210584bkz.22
        for <linux-can@vger.kernel.org>; Wed, 22 Jan 2014 23:21:39 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>

Hi Oliver and Marc,

what is the reason for slcand accepting only tty* and not both
variants tty* and /dev/tty*?

Regards,
Yegor
