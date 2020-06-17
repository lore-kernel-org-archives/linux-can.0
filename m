From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/6] Add Microchip MCP25XXFD CAN driver
Date: Thu, 18 Jun 2020 00:36:29 +0200
Message-ID: <2e80e2ed-d63d-5cc6-e1c6-e0c9e75c218e@pengutronix.de>
References: <20200610074442.10808-1-manivannan.sadhasivam@linaro.org>
 <fbbca009-3c53-6aa9-94ed-7e9e337c31a4@pengutronix.de>
 <20200617165902.GB14228@x1.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgFQWgu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 17 Jun 2020 18:36:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19967C06174E
        for <linux-can@vger.kernel.org>; Wed, 17 Jun 2020 15:36:50 -0700 (PDT)
In-Reply-To: <20200617165902.GB14228@x1.vandijck-laurijssen.be>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, wg@grandegger.com, kernel@martin.sperl.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>

On 6/17/20 6:59 PM, Kurt Van Dijck wrote:
> I'm in the process of getting a Variscite imx8m mini SOM online, with

Have your heard about the imx8m plus? It has CAN cores! We have a board in the
office to play with. :)

> MCP2517FD. The 4.19 kernel that comes with it, has a driver that is

You shall not start projects with 1,5 years old kernel.
And you probably shall not use vendor kernel for new projects.
:D

> clearly inspired by the one of Martin Sperl (not investigated too much
> yet). I have problems of probing the chip when the bus is under full
> load (under not full load, the probing only occasionally fails) due to
> the modeswitch test.
> 
> Is there a real difference in yours between the rpi and sunxi branches?

The sunxi branch has some sunxi SPI driver improvements, the rpi branch some for
the raspi SPI drivers. All branches with the same -xx should have the same
mcp25xxfd driver.

With the exception the latest version is v5.6-rpi/mcp25xxfd-20200607-41, which
is cleaned up for mainlining (it has the logging and dump stuff removed).

> Is there much evolution since -36 or would you mind to backport your
> latest -42 to 4.19?

Not much, some bus off cleanups, however I've backported all changes to
v4.19-rpi/mcp25xxfd-20200429-41 (debug and log is still included).

When you port this to your mx8 take all from (including)

    097701d1ea4f can: dev: avoid long lines
to
    v4.19-rpi/mcp25xxfd-20200429-41

> I will work on this the upcoming days. I can't do extensive tests, but
> rather a works-for-me test that includes bitrate probe.
> I only have 1 such board right now, and no other FD hardware.

Great, looking for feedback! Especially how the driver copes with your fully
loaded bus test.

regards,
Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
