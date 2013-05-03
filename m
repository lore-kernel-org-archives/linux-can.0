From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH, RFC 01/22] can: move CONFIG_HAVE_CAN_FLEXCAN out of CAN_DEV
Date: Fri, 3 May 2013 17:24:15 +0200
Message-ID: <201305031724.15584.arnd@arndb.de>
References: <1367507786-505303-1-git-send-email-arnd@arndb.de> <1367507786-505303-2-git-send-email-arnd@arndb.de> <5183892B.8020400@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5183892B.8020400@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

On Friday 03 May 2013, Marc Kleine-Budde wrote:
> On 05/02/2013 05:16 PM, Arnd Bergmann wrote:
> > CONFIG_HAVE_CAN_FLEXCAN is a silect symbol that is meant to be selected
> > by platforms that support this driver, but that is not possible without
> > also selecting CAN_DEV, unless we move it out of the "if CAN_DEV"
> > section of the Kconfig file.
> > 
> > warning: (SOC_IMX28 && SOC_IMX25 && SOC_IMX35 &&
> >  IMX_HAVE_PLATFORM_FLEXCAN && SOC_IMX53 && SOC_IMX6Q) selects HAVE_CAN_FLEXCAN
> >  which has unmet direct dependencies (NET && CAN && CAN_DEV)
> 
> With the advent of multi platform kernels I like to get rid of
> HAVE_CAN_FLEXCAN completely.

Yes, good idea. Are there any other dependencies we need to add then?
I assume FLEXCAN needs to depend on HAS_IOMEM and OF at least, but
there might be more.

	Arnd
