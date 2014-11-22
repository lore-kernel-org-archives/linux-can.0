From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 06/10] ARM: dts: am4372: Add DCAN nodes
Date: Fri, 21 Nov 2014 16:08:54 -0800
Message-ID: <20141122000853.GI7046@atomide.com>
References: <1415881371-4982-1-git-send-email-rogerq@ti.com>
 <1415881371-4982-7-git-send-email-rogerq@ti.com>
 <5469F35D.80504@ti.com>
 <20141121235032.GC7046@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:51100 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752160AbaKVAJJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 21 Nov 2014 19:09:09 -0500
Content-Disposition: inline
In-Reply-To: <20141121235032.GC7046@atomide.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Roger Quadros <rogerq@ti.com>
Cc: wg@grandegger.com, mkl@pengutronix.de, wsa@the-dreams.de, mugunthanvnm@ti.com, george.cherian@ti.com, balbi@ti.com, nsekhar@ti.comnm@ti.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, linux-can@vger.kernel.org, devicetree@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [141121 15:52]:
> * Roger Quadros <rogerq@ti.com> [141117 05:10]:
> > The SoC contains 2 DCAN modules. Add them.
> 
> Thanks applying all into omap-for-v3.19/dt-v2.

Oops, have to drop these as they cause this on make dtbs:

  DTC     arch/arm/boot/dts/dra7-evm.dtb
Warning (reg_format): "reg" property in /soc/can@481cc000 has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
Warning (reg_format): "reg" property in /soc/can@481d0000 has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
Warning (avoid_default_addr_size): Relying on default #address-cells value for /soc/can@481cc000
Warning (avoid_default_addr_size): Relying on default #size-cells value for /soc/can@481cc000
Warning (avoid_default_addr_size): Relying on default #address-cells value for /soc/can@481d0000
Warning (avoid_default_addr_size): Relying on default #size-cells value for /soc/can@481d0000
  DTC     arch/arm/boot/dts/am57xx-beagle-x15.dtb
Warning (reg_format): "reg" property in /soc/can@481cc000 has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
Warning (reg_format): "reg" property in /soc/can@481d0000 has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
Warning (avoid_default_addr_size): Relying on default #address-cells value for /soc/can@481cc000
Warning (avoid_default_addr_size): Relying on default #size-cells value for /soc/can@481cc000
Warning (avoid_default_addr_size): Relying on default #address-cells value for /soc/can@481d0000
Warning (avoid_default_addr_size): Relying on default #size-cells value for /soc/can@481d0000
  DTC     arch/arm/boot/dts/dra72-evm.dtb
Warning (reg_format): "reg" property in /soc/can@481cc000 has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
Warning (reg_format): "reg" property in /soc/can@481d0000 has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
Warning (avoid_default_addr_size): Relying on default #address-cells value for /soc/can@481cc000
Warning (avoid_default_addr_size): Relying on default #size-cells value for /soc/can@481cc000
Warning (avoid_default_addr_size): Relying on default #address-cells value for /soc/can@481d0000
Warning (avoid_default_addr_size): Relying on default #size-cells value for /soc/can@481d0000

Care to update the patches for that and then do a pull request for me?

Regards,

Tony
