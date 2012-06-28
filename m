From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] can: flexcan: use of_property_read_u32 to avoid endian problem
Date: Thu, 28 Jun 2012 11:32:19 +0800
Message-ID: <CAAQ0ZWTE=sF7-bnL6RZ8BuUQEmH+YtRE5J2A+mqsMPpsf6W_vw@mail.gmail.com>
References: <1340852337-19840-1-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:46438 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932265Ab2F1DcV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 Jun 2012 23:32:21 -0400
Received: by lbbgm6 with SMTP id gm6so2489000lbb.19
        for <linux-can@vger.kernel.org>; Wed, 27 Jun 2012 20:32:20 -0700 (PDT)
In-Reply-To: <1340852337-19840-1-git-send-email-jason77.wang@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Hui Wang <jason77.wang@gmail.com>
Cc: mkl@pengutronix.de, davem@davemloft.net, wg@grandegger.com, linux-can@vger.kernel.org

On 28 June 2012 10:58, Hui Wang <jason77.wang@gmail.com> wrote:
> Use of_property_read_u32() to get DT value can avoid endian problems,
> this is needed since this driver can run on powerpc (be) and arm (le).
>
> No need to check ret value here since we will check the got value to
> verify if users pass a valid value in the DT.
>
> Cc: linux-can@vger.kernel.org
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Shawn Guo <shawn.guo@linaro.org>

Reviewed-by: Shawn Guo <shawn.guo@linaro.org>

> Cc: Wolfgang Grandegger <wg@grandegger.com>
> Signed-off-by: Hui Wang <jason77.wang@gmail.com>
