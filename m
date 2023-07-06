Return-Path: <linux-can-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE87EB64DD
	for <linux-can@archiver.kernel.org>; Thu,  6 Jul 2023 20:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjGFUsO (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 6 Jul 2023 16:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjGFUsN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 6 Jul 2023 16:48:13 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C731992;
        Thu,  6 Jul 2023 13:48:12 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 08CE4209B4;
        Thu,  6 Jul 2023 22:48:09 +0200 (CEST)
Date:   Thu, 6 Jul 2023 22:48:04 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Judith Mendez <jm@ti.com>
Cc:     Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
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
Subject: Re: [PATCH 0/2] Enable multiple MCAN on AM62x
Message-ID: <ZKcohPM0OpM/mQtq@francesco-nb.int.toradex.com>
References: <20230705195356.866774-1-jm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705195356.866774-1-jm@ti.com>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, Jul 05, 2023 at 02:53:54PM -0500, Judith Mendez wrote:
> v9:
> - Change add MS to HRTIMER_POLL_INTERVAL
> - Change syntax from "= 0" to "!"

Please add the series version to the mail subject, you did it up to v8,
and you forgot now.

Thanks!
Francesco

