Return-Path: <linux-can-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C0AEB64D7
	for <linux-can@archiver.kernel.org>; Fri, 16 Jun 2023 12:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344778AbjFPMBQ (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Fri, 16 Jun 2023 08:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbjFPMBP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 16 Jun 2023 08:01:15 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49677273F;
        Fri, 16 Jun 2023 05:01:12 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 345E22168C;
        Fri, 16 Jun 2023 14:01:08 +0200 (CEST)
Date:   Fri, 16 Jun 2023 14:01:02 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Judith Mendez <jm@ti.com>
Cc:     Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Schuyler Patton <spatton@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH 4/4] DO_NOT_MERGE arm64: dts: ti: Enable MCU MCANs for
 AM62x
Message-ID: <ZIxO/uo7FICKsmdb@francesco-nb.int.toradex.com>
References: <20230419223323.20384-1-jm@ti.com>
 <20230419223323.20384-5-jm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419223323.20384-5-jm@ti.com>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, Apr 19, 2023 at 05:33:23PM -0500, Judith Mendez wrote:
> On AM62x there are no hardware interrupts routed to GIC interrupt
> controller for MCU MCAN IP, A53 Linux cannot receive hardware
> interrupts. Since an hrtimer will be used to generate software
> interrupts, add MCU MCAN nodes to dtsi and default to disabled.
> 
> AM62x does not carry on-board CAN transceivers, so instead of
> changing DTB permanently use an overlay to enable MCU MCANs and to
> add CAN transceiver nodes.
> 
> If an hrtimer is used to generate software interrupts, the two
> required interrupt attributes in the MCAN node do not have to be
> included.
> 
> Signed-off-by: Judith Mendez <jm@ti.com>

[...]

> +	mcu_mcan1: can@4e00000 {
this should be mcu_mcan0

> +		compatible = "bosch,m_can";
> +		reg = <0x00 0x4e00000 0x00 0x8000>,
> +			  <0x00 0x4e08000 0x00 0x200>;

[...]

> +	mcu_mcan2: can@4e10000 {
mcu_mcan1

> +		compatible = "bosch,m_can";
> +		reg = <0x00 0x4e10000 0x00 0x8000>,
> +			  <0x00 0x4e18000 0x00 0x200>;

Francesco
