From: Michael Walle <michael@walle.cc>
Subject: Re: [PATCH 0/8] can: flexcan: add CAN FD support for NXP Flexcan
Date: Thu, 13 Feb 2020 20:20:27 +0100
Message-ID: <20200213192027.4813-1-michael@walle.cc>
References: <24eb5c67-4692-1002-2468-4ae2e1a6b68b@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <24eb5c67-4692-1002-2468-4ae2e1a6b68b@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Joakim Zhang <qiangqing.zhang@nxp.com>, wg@grandegger.com, netdev@vger.kernel.org, linux-can@vger.kernel.org, Pankaj Bansal <pankaj.bansal@nxp.com>, Michael Walle <michael@walle.cc>
List-Id: linux-can.vger.kernel.org

Hi,

>>> Are you prepared to add back these patches as they are necessary for
>>> Flexcan CAN FD? And this Flexcan CAN FD patch set is based on these
>>> patches.
>>
>> Yes, these patches will be added back.
>
>I've cleaned up the first patch a bit, and pushed everything to the
>testing branch. Can you give it a test.

What happend to that branch? FWIW I've just tried the patches on a custom
board with a LS1028A SoC. Both CAN and CAN-FD are working. I've tested
against a Peaktech USB CAN adapter. I'd love to see these patches upstream,
because our board also offers CAN and basic support for it just made it
upstream [1].

If these patches are upstream, only the device tree nodes seems to be
missing. I don't know what has happened to [2]. But the patch doesn't seem
to be necessary.

Pankaj already send a patch to add the device node to the LS1028A [3].
Thats basically the same I've used, only that mine didn't had the
"fsl,ls1028ar1-flexcan" compatiblity string, but only the
"lx2160ar1-flexcan" which is the correct way to use it, right?

Sorry for putting this all in one mail, but I've just subscribed to
linux-can and there is no message archive on lore.kernel.org for it :/

[1] https://lore.kernel.org/lkml/20200212073617.GA11096@dragon/
[2] https://www.spinics.net/lists/linux-can/msg01584.html
[3] https://www.spinics.net/lists/linux-can/msg01577.html

-michael
