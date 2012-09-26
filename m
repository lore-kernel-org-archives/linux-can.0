From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH] can: can_oc: Add driver for CAN_OC cores from Aeroflex
 Gaisler
Date: Wed, 26 Sep 2012 11:56:15 +0200
Message-ID: <5062D13F.1090908@grandegger.com>
References: <1348552379-3909-1-git-send-email-andreas@gaisler.com> <5062CD27.3090803@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:58293 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119Ab2IZJ4b (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 26 Sep 2012 05:56:31 -0400
In-Reply-To: <5062CD27.3090803@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Andreas Larsson <andreas@gaisler.com>, linux-can@vger.kernel.org, software@gaisler.com

On 09/26/2012 11:38 AM, Marc Kleine-Budde wrote:
> On 09/25/2012 07:52 AM, Andreas Larsson wrote:
>> This driver is for the sja1000 compatible CAN_OC cores from Aeroflex
>> Gaisler available in the GRLIB VHDL IP core library.
> 
> Why don't you describe a single sja1000 compatible core with an OF
> device? The devices have indipendent address spaces and IRQs. With a
> proper abstraction/desciption you would not need this driver.

Right, at least I do not see anything special. The following DTS entry
should do the jobs:


  /* First CAN device */
  can@3,100 {
        compatible = "nxp,sja1000";
        reg = <3 0x100 0x80>;
        interrupts = <2 0>;
        interrupt-parent = <&mpic>;
        nxp,external-clock-frequency = <16000000>;
  };

  /* Second CAN device */
  can@3,200 {
        compatible = "nxp,sja1000";
        reg = <3 0x200 0x80>;
        interrupts = <2 0>;
        interrupt-parent = <&mpic>;
        nxp,external-clock-frequency = <16000000>;
  };

Addresses and IRQs might be different, of course.

See also;


http://lxr.linux.no/#linux+v3.5.4/Documentation/devicetree/bindings/net/can/sja1000.txt

Wolfgang.
