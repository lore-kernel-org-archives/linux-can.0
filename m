Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F915C433B4
	for <linux-can@archiver.kernel.org>; Thu, 15 Apr 2021 09:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AC3E61152
	for <linux-can@archiver.kernel.org>; Thu, 15 Apr 2021 09:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhDOJNJ (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 15 Apr 2021 05:13:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39419 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbhDOJNJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 15 Apr 2021 05:13:09 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lWy3J-0002hA-6U; Thu, 15 Apr 2021 09:12:45 +0000
Subject: Re: [PATCH][next] can: etas_es58x: Fix potential null pointer
 dereference on pointer cf
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210415085535.1808272-1-colin.king@canonical.com>
 <20210415090314.vvyvr2wihwnauyi6@pengutronix.de>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <c2d87a09-118a-7521-b78f-a7af114046fc@canonical.com>
Date:   Thu, 15 Apr 2021 10:12:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210415090314.vvyvr2wihwnauyi6@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 15/04/2021 10:03, Marc Kleine-Budde wrote:
> On 15.04.2021 09:55:35, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> The pointer cf is being null checked earlier in the code, however the
>> update of the rx_bytes statistics is dereferencing cf without null
>> checking cf.  Fix this by moving the statement into the following code
>> block that has a null cf check.
>>
>> Addresses-Coverity: ("Dereference after null check")
>> Fixes: 8537257874e9 ("can: etas_es58x: add core support for ETAS ES58X CAN USB interfaces")
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> A somewhat different fix is already in net-next/master
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=e2b1e4b532abdd39bfb7313146153815e370d60c

+1 on that

> 
> Marc
> 

