From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v3 1/6] can: m_can: Disabled Interrupt Line 1
Date: Sat, 25 Mar 2017 16:33:09 +0100
Message-ID: <fd729127-a0a6-c3ab-0e37-cb45a96acefd@hartkopp.net>
References: <1490374171-15190-1-git-send-email-mario.huettel@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:22466 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbdCYPdR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 25 Mar 2017 11:33:17 -0400
In-Reply-To: <1490374171-15190-1-git-send-email-mario.huettel@de.bosch.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mario Huettel <mario.huettel@de.bosch.com>, linux-can@vger.kernel.org



On 03/24/2017 05:49 PM, Mario Huettel wrote:
> * Disabled interrupt line 1. The driver didn't use it.
>
> Signed-off-by: Mario Huettel <mario.huettel@de.bosch.com>

Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>

> ---
>  drivers/net/can/m_can/m_can.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 7a6554e..6797977 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -349,7 +349,8 @@ static inline void m_can_config_endisable(const struct m_can_priv *priv,
>
>  static inline void m_can_enable_all_interrupts(const struct m_can_priv *priv)
>  {
> -	m_can_write(priv, M_CAN_ILE, ILE_EINT0 | ILE_EINT1);
> +	/* Only interrupt line 0 is used in this driver */
> +	m_can_write(priv, M_CAN_ILE, ILE_EINT0);
>  }
>
>  static inline void m_can_disable_all_interrupts(const struct m_can_priv *priv)
>
