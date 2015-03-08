From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] autotools: define N_SLCAN, if not already declared
Date: Sun, 08 Mar 2015 15:57:56 +0100
Message-ID: <54FC6374.2060002@hartkopp.net>
References: <1425823253-27821-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:56601 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824AbbCHO6D (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 8 Mar 2015 10:58:03 -0400
In-Reply-To: <1425823253-27821-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yegor Yefremov <yegorslists@googlemail.com>, linux-can@vger.kernel.org

Good idea!

Actually a colleague recently had the problem that N_SLCAN was not defined on 
some older Redhat 6.x machine with 2.6.32 Kernel and 'even older' includes.

The patch from Jeremiah which was removing this private define

https://github.com/linux-can/can-utils/commit/ca7990919717b8e2c841552139ad221e58e8bb69

created the compile issue. So your patch fixes this problem in the correct way :-)

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Thanks,
Oliver

On 08.03.2015 15:00, Yegor Yefremov wrote:
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> ---
>   configure.ac | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/configure.ac b/configure.ac
> index 3b695d3..633ba81 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -83,6 +83,9 @@ AC_CHECK_DECL(PF_CAN,,
>   AC_CHECK_DECL(AF_CAN,,
>       [AC_DEFINE([AF_CAN], [PF_CAN], [AF_CAN])]
>   )
> +AC_CHECK_DECL(N_SLCAN,,
> +    [AC_DEFINE([N_SLCAN], [17], [N_SLCAN])]
> +)
>
>
>   #
>
