Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA66C433F5
	for <linux-can@archiver.kernel.org>; Wed, 11 May 2022 13:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbiEKNYH (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 11 May 2022 09:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbiEKNYG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 11 May 2022 09:24:06 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C27D19C00;
        Wed, 11 May 2022 06:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1652275441;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=MsQ/NA1+upPikalsW6cbiUqrtcPq2xMKVaszX0ZMtVU=;
    b=LoCb2AeDuqjsFsWg9QjosjUchr8P0g74a2+dFWIyfyJfjAAOZ4MhSP2YKTb29T/AeZ
    yoTDIhuXOIt1fh6kyBhcEwzbKPsMeSvCwaoHRvJOSkJNv2CcZtIjk35ffDqMy1wKCeid
    OV65bXnX09LlScJNoFdvg6s3VNkBK+ZNVNEFZNlLtu+nbVflI7yLsgx1zZLYZFN4hjnm
    81clrEy5mdKl8Of+ZA9D9QWmvR9BKoRKKyO/9zFoy+7SlQU0Kgi5RQ17JCysgX/DjAOl
    vrNuITBsy0v7GMRWvaCRHAbIFFDGfjvbOMVBgXd+JjQBVIwd8THtWjpxwW3mlANGrNIi
    sepw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdBqPeOuh2koeKQvJnLjhchY2TXGXhEF98MlNg=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cff:5b00:9642:f755:5daa:777e]
    by smtp.strato.de (RZmta 47.42.2 AUTH)
    with ESMTPSA id 4544c9y4BDO1yFk
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 11 May 2022 15:24:01 +0200 (CEST)
Message-ID: <6f541d66-f52e-13e0-bfe9-91918af11503@hartkopp.net>
Date:   Wed, 11 May 2022 15:24:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/1] can: skb: add and set local_origin flag
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Devid Antonio Filoni <devid.filoni@egluetechnologies.com>,
        kernel@pengutronix.de, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Jander <david@protonic.nl>
References: <20220511121913.2696181-1-o.rempel@pengutronix.de>
 <b631b022-72d5-9160-fd13-f33c80dbbe59@hartkopp.net>
 <20220511130540.yowjdvzftq2jutiw@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20220511130540.yowjdvzftq2jutiw@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 5/11/22 15:05, Marc Kleine-Budde wrote:
> On 11.05.2022 14:38:32, Oliver Hartkopp wrote:
>> I'm a bit unsure why we should not stick with the simple skb->sk
>> handling?
> 
> Another use where skb->sk breaks is sending CAN frames with SO_TXTIME
> with the sched_etf.
> 
> I have a patched version of cangen that uses SO_TXTIME. It attaches a
> time to transmit to a CAN frame when sending it. If you send 10 frames,
> each 100ms after the other and then exit the program, the first CAN
> frames show up as TX'ed while the others (after closing the socket) show
> up as RX'ed CAN frames in candump.

Hm, this could be an argument for the origin flag.

But I'm more scared about your described behaviour. What happens if the 
socket is still open?

There obviously must be some instance removing the sk reference, right??

Regards,
Oliver
