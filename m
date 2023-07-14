Return-Path: <linux-can-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD11AC001B0
	for <linux-can@archiver.kernel.org>; Fri, 14 Jul 2023 10:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbjGNKAF (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Fri, 14 Jul 2023 06:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbjGNKAE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 Jul 2023 06:00:04 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55FB1BD4;
        Fri, 14 Jul 2023 02:59:58 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id D964B209BD;
        Fri, 14 Jul 2023 11:59:51 +0200 (CEST)
Date:   Fri, 14 Jul 2023 11:59:47 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Judith Mendez <jm@ti.com>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Schuyler Patton <spatton@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH v10 0/2] Enable multiple MCAN on AM62x
Message-ID: <ZLEckxW0oLklkMtn@francesco-nb.int.toradex.com>
References: <20230707204714.62964-1-jm@ti.com>
 <20230710-overheat-ruined-12d17707e324-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710-overheat-ruined-12d17707e324-mkl@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Mark,

On Mon, Jul 10, 2023 at 11:57:51AM +0200, Marc Kleine-Budde wrote:
> On 07.07.2023 15:47:12, Judith Mendez wrote:
> > On AM62x there are two MCANs in MCU domain. The MCANs in MCU domain
> > were not enabled since there is no hardware interrupt routed to A53
> > GIC interrupt controller. Therefore A53 Linux cannot be interrupted
> > by MCU MCANs.
...

> Applied to linux-can-next/testing.

Did you forgot to push your changes out? Nothing here
git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git

Francesco

