Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD10C38A2D
	for <linux-can@archiver.kernel.org>; Tue, 25 Oct 2022 02:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiJYCdD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-can@archiver.kernel.org>);
        Mon, 24 Oct 2022 22:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiJYCdC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 24 Oct 2022 22:33:02 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CD911A97C;
        Mon, 24 Oct 2022 19:33:01 -0700 (PDT)
Received: from smtpclient.apple ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=PLAIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 29P2Tohs020938-29P2Tohu020938
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 25 Oct 2022 10:29:50 +0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH] can: mscan: mpc5xxx: fix error handling code in
 mpc5xxx_can_probe
From:   Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <Y1Z+XHdOozjBFBzF@smile.fi.intel.com>
Date:   Tue, 25 Oct 2022 10:29:50 +0800
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Wolfram Sang <wsa@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Gerhard Sittig <gsi@denx.de>,
        Anatolij Gustschin <agust@denx.de>,
        Mark Brown <broonie@kernel.org>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <6A916694-CA4E-4D73-8CF0-B35AC8C6B9D3@hust.edu.cn>
References: <20221024114810.732168-1-dzm91@hust.edu.cn>
 <Y1Z+XHdOozjBFBzF@smile.fi.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



> On Oct 24, 2022, at 20:00, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> On Mon, Oct 24, 2022 at 07:48:07PM +0800, Dongliang Mu wrote:
>> The commit 1149108e2fbf ("can: mscan: improve clock API use
>> ") only adds put_clock in mpc5xxx_can_remove function, forgetting to add
> 
> Strange indentation. Why the '")' part can't be on the previous line?

:/ it is automatically done by vim in `git commit -a -s -e`. I can adjust this part in v2 patch.

> 
>> put_clock in the error handling code.
>> 
>> Fix this bug by adding put_clock in the error handling code.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 

