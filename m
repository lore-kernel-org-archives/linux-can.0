From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: [PATCH 0/6] Add Microchip MCP25XXFD CAN driver
Date: Thu, 18 Jun 2020 14:30:55 +0200
Message-ID: <20200618123055.GA17496@x1.vandijck-laurijssen.be>
References: <20200610074442.10808-1-manivannan.sadhasivam@linaro.org>
 <fbbca009-3c53-6aa9-94ed-7e9e337c31a4@pengutronix.de>
 <20200617165902.GB14228@x1.vandijck-laurijssen.be>
 <2e80e2ed-d63d-5cc6-e1c6-e0c9e75c218e@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b03.edpnet.be ([212.71.1.220]:39861 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727944AbgFRMbP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 18 Jun 2020 08:31:15 -0400
Content-Disposition: inline
In-Reply-To: <2e80e2ed-d63d-5cc6-e1c6-e0c9e75c218e@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, wg@grandegger.com, kernel@martin.sperl.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

On do, 18 jun 2020 00:36:29 +0200, Marc Kleine-Budde wrote:
> On 6/17/20 6:59 PM, Kurt Van Dijck wrote:
> > I'm in the process of getting a Variscite imx8m mini SOM online, with
> 
> Have your heard about the imx8m plus? It has CAN cores! We have a board in the
> office to play with. :)
> 
> > MCP2517FD. The 4.19 kernel that comes with it, has a driver that is
> 
> You shall not start projects with 1,5 years old kernel.
> And you probably shall not use vendor kernel for new projects.
> :D

your rpi kernel starts of v4.19.119 (or so), where the variscite starts
of v4.19.35.
The result was quite some list of merge conflicts, on top of a vendor
kernel, so I took your advise and switched to the latest and greatest
5.7.3.
Luckily, we need no sound (yet) and no video. :-)

> 
> Not much, some bus off cleanups, however I've backported all changes to
> v4.19-rpi/mcp25xxfd-20200429-41 (debug and log is still included).
> 
> When you port this to your mx8 take all from (including)
> 
>     097701d1ea4f can: dev: avoid long lines
> to
>     v4.19-rpi/mcp25xxfd-20200429-41
> 

I'll merge one of your latest ...

Kurt
