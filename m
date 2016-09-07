From: Holger Schurig <holgerschurig@gmail.com>
Subject: Re: [PATCH v2 00/12] can: rx-offload: add implmentation and switch flexcan driver to use it
Date: Wed, 07 Sep 2016 08:33:57 +0200
Message-ID: <878tv48bhm.fsf@gmail.com>
References: <1467657137-18891-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33213 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754746AbcIGGeA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 7 Sep 2016 02:34:00 -0400
Received: by mail-wm0-f67.google.com with SMTP id w207so1295032wmw.0
        for <linux-can@vger.kernel.org>; Tue, 06 Sep 2016 23:34:00 -0700 (PDT)
In-Reply-To: <1467657137-18891-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

Marc Kleine-Budde <mkl@pengutronix.de> writes:

Late answer :-)

This driver was tested with Linux 4.7.2 an on i.MX6Q device. Not by me,
I don't even have their exact test software. I just get the reports ...


Using some external tool (maybe Kvaser?) they generated 80% busload at
500 kbps, the driver survived for 3 days without any data loss. So,
compared with the current in-kernel driver, this is a definitive
improvement!



Then they did same CAN ping-ping test with reboots and wrote: "Out of
about 16,000 reboots we had one failure. This failed both CAN interfaces
and the logs show that the PTX-C received all CAN messages and returned
them, but the test machine for some reason did not receive any CAN
messages."

I don't have any idea why Linux thought it was sending but the receiver
didn't receive anything. And I'm no CAN expert, not at all. Wouldn't I
get an error condition on the sending side?   How would a program get
this error, is it a return value to sendto()

Holger
