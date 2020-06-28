From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v41 3/3] can: mcp25xxfd: initial commit
Date: Sun, 28 Jun 2020 12:18:02 +0530
Message-ID: <12A4ECA5-4DB0-4623-A2ED-3F98CA16F44F@linaro.org>
References: <20200622114603.965371-1-mkl@pengutronix.de> <20200622114603.965371-4-mkl@pengutronix.de> <20200626133243.GA8333@Mani-XPS-13-9360> <20200627195605.GC30275@x1.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgF1GsO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 28 Jun 2020 02:48:14 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93852C061794
        for <linux-can@vger.kernel.org>; Sat, 27 Jun 2020 23:48:14 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id j1so6529601pfe.4
        for <linux-can@vger.kernel.org>; Sat, 27 Jun 2020 23:48:14 -0700 (PDT)
In-Reply-To: <20200627195605.GC30275@x1.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org



On 28 June 2020 1:26:05 AM IST, Kurt Van Dijck <dev=2Ekurt@vandijck-laurij=
ssen=2Ebe> wrote:
>On vr, 26 jun 2020 19:02:43 +0530, Manivannan Sadhasivam wrote:
>> Hi,
>>=20
>> On Mon, Jun 22, 2020 at 01:46:03PM +0200, Marc Kleine-Budde wrote:
>> > This patch add support for the Microchip MCP25xxFD SPI CAN
>controller family=2E
>> >=20
>> > Pending-Tested-by: Kurt Van Dijck <dev=2Ekurt@vandijck-laurijssen=2Eb=
e>
>> > Pending-Tested-by: Manivannan Sadhasivam
><manivannan=2Esadhasivam@linaro=2Eorg>
>> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix=2Ede>
>>=20
>> Could you please split this patch into multiple ones? Having ~4k
>lines for a
>> patch makes it difficult to review=2E I know that some parts are
>difficult to
>> split (happened with my series as well) but anything below 1k should
>be fine=2E
>
>IMHO, there is a huge difference between a complete new driver of 4k
>lines and a change of 100 lines=2E
>It's useless to add a non-functional driver, only to add functionality
>later on=2E
>

I just asked to split commits in this series logically=2E Because, its har=
d for the reviewers to do the review of a bulk patch=2E This is an unwritte=
n rule of the kernel community=2E=2E=2E=20

>You're right concerning real changes to a driver=2E
>
>Just my opinion =2E=2E=2E
>
From what I see, Marc did a good job, providing minimal functionality
>in
>the first series=2E now, the driver can evolve (like adding listen-only
>:-) )

Again, I have no concern over the patch series=2E I'm also planning to sub=
mit incremental patches on top of this=2E=20

Thanks,=20
Mani=20
>
>Kurt
>
>>=20
>> Thanks,
>> Mani
>>=20
>> > ---
>> >  drivers/net/can/spi/Kconfig                   |    2 +
>> >  drivers/net/can/spi/Makefile                  |    1 +
>> >  drivers/net/can/spi/mcp25xxfd/Kconfig         |   17 +
>> >  drivers/net/can/spi/mcp25xxfd/Makefile        |    8 +
>> >  =2E=2E=2E/net/can/spi/mcp25xxfd/mcp25xxfd-core=2Ec    | 2890
>+++++++++++++++++
>> >  =2E=2E=2E/net/can/spi/mcp25xxfd/mcp25xxfd-crc16=2Ec   |   89 +
>> >  =2E=2E=2E/net/can/spi/mcp25xxfd/mcp25xxfd-regmap=2Ec  |  554 ++++
>> >  drivers/net/can/spi/mcp25xxfd/mcp25xxfd=2Eh     |  828 +++++
>> >  8 files changed, 4389 insertions(+)
>> >  create mode 100644 drivers/net/can/spi/mcp25xxfd/Kconfig
>> >  create mode 100644 drivers/net/can/spi/mcp25xxfd/Makefile
>> >  create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core=2Ec
>> >  create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-crc16=2Ec
>> >  create mode 100644
>drivers/net/can/spi/mcp25xxfd/mcp25xxfd-regmap=2Ec
>> >  create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd=2Eh
>> >=20

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
