From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH] autotools: fix syntax error
Date: Thu, 3 Sep 2015 13:53:12 +0200
Message-ID: <CAGm1_kvHUgo3gs9vHkp8SqwwM2Z1Yc=CPF8tLWxMgLk0iViD7w@mail.gmail.com>
References: <1438963526-31603-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-vk0-f42.google.com ([209.85.213.42]:34745 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010AbbICL7X (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 Sep 2015 07:59:23 -0400
Received: by vkhf67 with SMTP id f67so22864367vkh.1
        for <linux-can@vger.kernel.org>; Thu, 03 Sep 2015 04:59:22 -0700 (PDT)
In-Reply-To: <1438963526-31603-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Yegor Yefremov <yegorslists@googlemail.com>, Marc Kleine-Budde <mkl@pengutronix.de>

On Fri, Aug 7, 2015 at 6:05 PM,  <yegorslists@googlemail.com> wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
>
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> ---
>  configure.ac | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/configure.ac b/configure.ac
> index 633ba81..8b50fb7 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -20,7 +20,7 @@ AC_PROG_CC
>  LT_INIT(win32-dll)
>
>  AM_INIT_AUTOMAKE([foreign no-exeext dist-bzip2])
> -m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes]]))
> +m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])
>
>  #
>  # Checks for header files.
> --
> 2.1.4
>

Ping?
