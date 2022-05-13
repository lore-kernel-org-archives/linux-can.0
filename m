Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4436DC433F5
	for <linux-can@archiver.kernel.org>; Fri, 13 May 2022 17:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382605AbiEMRkK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-can@archiver.kernel.org>);
        Fri, 13 May 2022 13:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379077AbiEMRkK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 13 May 2022 13:40:10 -0400
X-Greylist: delayed 83421 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 13 May 2022 10:40:08 PDT
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2BDB9289BD;
        Fri, 13 May 2022 10:40:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id 7B5CDFFCE9;
        Fri, 13 May 2022 17:40:06 +0000 (UTC)
Date:   Fri, 13 May 2022 19:40:03 +0200
From:   Max Staudt <max@enpas.org>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] can: drop tx skb if the device is in listen only
 mode
Message-ID: <20220513194003.10f72402.max@enpas.org>
In-Reply-To: <20220513153606.302464-1-mailhol.vincent@wanadoo.fr>
References: <20220513142355.250389-1-mailhol.vincent@wanadoo.fr>
        <20220513153606.302464-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From my view (I don't have the big picture here), this series looks good
to me. Thanks!


Max
