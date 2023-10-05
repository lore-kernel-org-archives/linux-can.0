Return-Path: <linux-can-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D37E71D4F
	for <linux-can@archiver.kernel.org>; Thu,  5 Oct 2023 16:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjJEQza (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 5 Oct 2023 12:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbjJEQyX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 12:54:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1048C35A7;
        Thu,  5 Oct 2023 09:44:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F46C433C8;
        Thu,  5 Oct 2023 16:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696524262;
        bh=mK/SNXCOe8N+XAarC6tZtnfOgjStW1fvXDMBaMxfJQw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZRHuwt1WdMrORRlFmhmDt9j/0/po7jJOFwurVcNILq3hUsOLteIjKuR2a9nw4usuT
         qD8H4/cUTBU1arQNV1qp6FXe1wHkZQ1+NPfCmLT+s3OlQBJoTa4WTVRBNkf8vesknV
         2WZtCCkaG3o6+f8hWEzgnurvUK+XN9WQgiiJCq6QMj3iraTR/AWEbrYjklsk8u/PU0
         B+WZ56dolOKWlFOpDBH9VQZPqWcClCJOHvsjxOD1k+UKwzKbJ6eOrBp1gKWuWVXejk
         rIfZtUzv6j7qn8sxctnHkpnsOyjX0MxAIOrnsnwvKu3LZGgsW5hsKz1U3nudoXllRu
         0QvoHmm43+7AQ==
Date:   Thu, 5 Oct 2023 09:44:21 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     netdev@vger.kernel.org, davem@davemloft.net,
        linux-can@vger.kernel.org, kernel@pengutronix.de,
        Sili Luo <rootlab@huawei.com>, stable@vger.kernel.org
Subject: Re: [PATCH net 1/7] can: j1939: Fix UAF in j1939_sk_match_filter
 during setsockopt(SO_J1939_FILTER)
Message-ID: <20231005094421.09a6a58f@kernel.org>
In-Reply-To: <20231005094639.387019-2-mkl@pengutronix.de>
References: <20231005094639.387019-1-mkl@pengutronix.de>
        <20231005094639.387019-2-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu,  5 Oct 2023 11:46:33 +0200 Marc Kleine-Budde wrote:
> Lock jsk->sk to prevent UAF when setsockopt(..., SO_J1939_FILTER, ...)
> modifies jsk->filters while receiving packets.

Doesn't it potentially introduce sleep in atomic?

j1939_sk_recv_match()
  spin_lock_bh(&priv->j1939_socks_lock);
  j1939_sk_recv_match_one()
    j1939_sk_match_filter()
      lock_sock()
        sleep
