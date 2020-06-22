From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: [PATCH 0/6] Add Microchip MCP25XXFD CAN driver
Date: Mon, 22 Jun 2020 12:25:59 +0200
Message-ID: <20200622102559.GA3077@x1.vandijck-laurijssen.be>
References: <20200610074442.10808-1-manivannan.sadhasivam@linaro.org>
 <fbbca009-3c53-6aa9-94ed-7e9e337c31a4@pengutronix.de>
 <20200617165902.GB14228@x1.vandijck-laurijssen.be>
 <2e80e2ed-d63d-5cc6-e1c6-e0c9e75c218e@pengutronix.de>
 <20200618123055.GA17496@x1.vandijck-laurijssen.be>
 <c8267280-e7a9-8171-d714-fa392ccb5537@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c8267280-e7a9-8171-d714-fa392ccb5537@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, wg@grandegger.com, kernel@martin.sperl.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Hey Marc,

On do, 18 jun 2020 14:35:28 +0200, Marc Kleine-Budde wrote:
> On 6/18/20 2:30 PM, Kurt Van Dijck wrote:
> > On do, 18 jun 2020 00:36:29 +0200, Marc Kleine-Budde wrote:
> >> On 6/17/20 6:59 PM, Kurt Van Dijck wrote:
> >>> I'm in the process of getting a Variscite imx8m mini SOM online, with
> >>
> >> Have your heard about the imx8m plus? It has CAN cores! We have a board in the
> >> office to play with. :)
> >>
> >>> MCP2517FD. The 4.19 kernel that comes with it, has a driver that is
> >>
> >> You shall not start projects with 1,5 years old kernel.
> >> And you probably shall not use vendor kernel for new projects.
> >> :D
> > 
> > your rpi kernel starts of v4.19.119 (or so), where the variscite starts
> > of v4.19.35.
> 
> You're missing some stable backports for the kernel then.
> 
> > The result was quite some list of merge conflicts, on top of a vendor
> > kernel, so I took your advise and switched to the latest and greatest
> > 5.7.3.
> 
> \o/

I got my board up with a 5.7, despite device-tree problems completely
unrelated to CAN.
It seems to work well with a fully-loaded CAN bus (cangen -g0 ...).
So that is a real improvement.
I will need to add the listen-only mode soon.

Kurt
