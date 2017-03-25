From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v3 3/6] can: m_can: Updated register defines to newest
 version
Date: Sat, 25 Mar 2017 16:32:13 +0100
Message-ID: <12494c93-ba26-0f4c-e1a4-1ad138ac4f34@hartkopp.net>
References: <1490374171-15190-1-git-send-email-mario.huettel@de.bosch.com>
 <1490374171-15190-3-git-send-email-mario.huettel@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:20175 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751181AbdCYPcR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 25 Mar 2017 11:32:17 -0400
In-Reply-To: <1490374171-15190-3-git-send-email-mario.huettel@de.bosch.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mario Huettel <mario.huettel@de.bosch.com>, linux-can@vger.kernel.org

Hi Mario,

On 03/24/2017 05:49 PM, Mario Huettel wrote:
> * Updated register defines to newest M_CAN version (v3.2.1).
> * Changed defines in the whole code.
>
> Signed-off-by: Mario Huettel <mario.huettel@de.bosch.com>
> ---
>  drivers/net/can/m_can/m_can.c | 190 +++++++++++++++++++++++++++---------------
>  1 file changed, 125 insertions(+), 65 deletions(-)
>
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index ddcbe8b..f2656a3 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c

> @@ -130,21 +132,32 @@ enum m_can_mram_cfg {
>  #define CCCR_CME_CAN		0
>  #define CCCR_CME_CANFD		0x1
>  #define CCCR_CME_CANFD_BRS	0x2
> +#define	CCCR_TXP		BIT(14)

Whitespace issue - which cannot be seen in the editor ... please put 
just one space after #define.

The rest looks fine :-)

Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>

