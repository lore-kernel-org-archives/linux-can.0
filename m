Return-Path: <linux-can-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5946CC001B0
	for <linux-can@archiver.kernel.org>; Fri, 11 Aug 2023 21:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbjHKVcL (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Fri, 11 Aug 2023 17:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbjHKVcL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 11 Aug 2023 17:32:11 -0400
Received: from mail.enpas.org (zhong.enpas.org [IPv6:2a03:4000:2:537::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB47A10D;
        Fri, 11 Aug 2023 14:32:09 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id 03320FFE0A;
        Fri, 11 Aug 2023 21:32:03 +0000 (UTC)
Message-ID: <295e08ba-8026-a16b-704a-c27b84b72eef@enpas.org>
Date:   Sat, 12 Aug 2023 06:32:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
From:   Max Staudt <max@enpas.org>
Subject: Re: [PATCH 13/36] tty: can327: unify error paths in can327_ldisc_rx()
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org
References: <20230810091510.13006-1-jirislaby@kernel.org>
 <20230810091510.13006-14-jirislaby@kernel.org>
Content-Language: en-US
In-Reply-To: <20230810091510.13006-14-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Thank you for simplifying this!

Reviewed-by: Max Staudt <max@enpas.org>


In case you're re-sending this series, may I ask for one empty line between the final "return;" and the new label "uart_failure:"?

