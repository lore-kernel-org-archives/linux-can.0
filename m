From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [RFC v2 2/7] c_can: rename callback "initram" to "init" to more general usage
Date: Mon, 03 Dec 2012 15:20:23 +0100
Message-ID: <1876011.7USXKpqpSd@ws-stein>
References: <1354199987-10350-1-git-send-email-wg@grandegger.com> <1354199987-10350-3-git-send-email-wg@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:45219 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754480Ab2LCOU0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 3 Dec 2012 09:20:26 -0500
In-Reply-To: <1354199987-10350-3-git-send-email-wg@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, bhupesh.sharma@st.com, tomoya.rohm@gmail.com

Hello Wolfgang,

On Thursday 29 November 2012 15:39:42, Wolfgang Grandegger wrote:
> The callback "init" is called with the argument "true" when the
> device is opened and with "false" when it is closed allowing for
> device specific initialization and cleanup, e.g. raminit or reset.
> 
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
> ---
>  drivers/net/can/c_can/c_can.c          |   16 ++++++++--------
>  drivers/net/can/c_can/c_can.h          |    2 +-
>  drivers/net/can/c_can/c_can_platform.c |    2 +-
>  3 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
> index 5233b8f..3ae356f 100644
> --- a/drivers/net/can/c_can/c_can.c
> +++ b/drivers/net/can/c_can/c_can.c
> @@ -233,10 +233,10 @@ static inline void c_can_pm_runtime_put_sync(const struct c_can_priv *priv)
>  		pm_runtime_put_sync(priv->device);
>  }
>  
> -static inline void c_can_reset_ram(const struct c_can_priv *priv, bool enable)

Where does c_can_reset_ram come from? I can't a patch to it in Linus' tree nor in linux-can repository.

Regards,
Alexander

