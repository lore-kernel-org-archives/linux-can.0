Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A74ECAAD8
	for <linux-can@archiver.kernel.org>; Fri, 23 Sep 2022 07:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiIWHht (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Fri, 23 Sep 2022 03:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiIWHht (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 23 Sep 2022 03:37:49 -0400
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497EB12849A
        for <linux-can@vger.kernel.org>; Fri, 23 Sep 2022 00:37:45 -0700 (PDT)
Date:   Fri, 23 Sep 2022 07:37:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jbrengineering.co.uk; s=protonmail; t=1663918663; x=1664177863;
        bh=fx24NLK7yEv6DL+vd8HHx4VkeaQSqQNYvam7EtAoOMI=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=qvYK4WuH6zKYwlomuCR8EqJa0Z0WnP6qETrqy0rR36fDHZ7GGD1IjSnJ6ULaErasZ
         8ILE6Gjjer1YWWqgsbusIz05D30W44SK3a3zLZzXASaucefRUsxoXH0geRJ+HnARxc
         m/fQgfn2m+P16PEmrDrOHzbbp9oOUOOzabY+U4t1CYvnaPAz0+SRtcrN+ZFNBghVLO
         ts3fOjqXmtasy/ddQkzwIJjcOwGB+NUXBKTj/ATPICJiJEF6Vhx/NPIVGVXK3taN6U
         irAQ4XjDrg+DmNEhMXIf/Ez9ynmpF7ixy+825pC6Yh4nK7IqMcQ2UkrKfgPyJL6a9n
         psSKoTfwyLbqg==
To:     Marc Kleine-Budde <mkl@pengutronix.de>
From:   john@jbrengineering.co.uk
Cc:     linux-can@vger.kernel.org,
        John Whittington <git@jbrengineering.co.uk>
Subject: Re: (No Subject)
Message-ID: <D5kQmUvoiojdgxcLcKIN3bKMicnjkm--Bvw9vLo7F0riXPPwcOT_RcDP_jWv3N3-5RjFQaaPk2vnS1DgHCJ4ML8Cozu20iSaR_8no0K_JKA=@jbrengineering.co.uk>
In-Reply-To: <20220921195804.iqiorhtcbehmpolb@pengutronix.de>
References: <20220920100416.959226-1-mkl@pengutronix.de> <wRg__4HuO0FuJrZu5M_JEbOd6MvCtxHq_aV86X_Bj-Dgb0YTRaoVO_sr6DpPcvwrhWtnNYwSCCWf0hJ8bCsFEYfon_iTkyctFDZOxOyO3x8=@jbrengineering.co.uk> <20220921195804.iqiorhtcbehmpolb@pengutronix.de>
Feedback-ID: 45109726:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

> Thanks, can I add your Tested-by?

Yep.

John.
