From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: request to queue "0d1862e can: flexcan: fix flexcan_chip_start() on imx6"
Date: Fri, 29 Nov 2013 23:43:51 +0100
Message-ID: <1385765032-23630-1-git-send-email-mkl@pengutronix.de>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Belser Florian <Florian.Belser@sensor-technik.de>
List-Id: linux-can.vger.kernel.org

Hello Greg,

can you please queue

    0d1862e can: flexcan: fix flexcan_chip_start() on imx6

for the stable trees.

As it does not apply clearly on stable [1], I've attached the patch with an
adjusted context.

regards,
Marc

[1] in trees with
    d5a7b40 can: flexcan: flexcan_chip_start: fix regression, mark one MB for TX and abort pending TX
    applied
