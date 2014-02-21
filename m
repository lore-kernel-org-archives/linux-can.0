From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH v3 4/5] can: introduce the data bitrate configuration for
 CAN FD
Date: Fri, 21 Feb 2014 09:27:39 +0100
Message-ID: <53070DFB.9080104@peak-system.com>
References: <1392481934-12569-1-git-send-email-socketcan@hartkopp.net>
 <1392481934-12569-4-git-send-email-socketcan@hartkopp.net>
Reply-To: Stephane Grosjean <s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:57701 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753583AbaBUI1y (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 21 Feb 2014 03:27:54 -0500
In-Reply-To: <1392481934-12569-4-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

Hi Oliver,

Only some nitpicking from my side, for the moment ...

Le 15/02/2014 17:32, Oliver Hartkopp a =E9crit :
>  =20
> @@ -730,6 +757,10 @@ static size_t can_get_size(const struct net_devi=
ce *dev)
>   	size +=3D nla_total_size(sizeof(u32));			/* IFLA_CAN_RESTART_MS */
>   	if (priv->do_get_berr_counter)				/* IFLA_CAN_BERR_COUNTER */
>   		size +=3D nla_total_size(sizeof(struct can_berr_counter));
> +	if (priv->data_bittiming.bitrate)			/* IFLA_DATA_CAN_BITTIMING */
> +		size +=3D nla_total_size(sizeof(struct can_bittiming));
> +	if (priv->data_bittiming_const)				/* IFLA_DATA_CAN_BITTIMING_CONST=
 */
> +		size +=3D nla_total_size(sizeof(struct can_bittiming_const));
>  =20
>   	return size;
>   }

IFLA_DATA_CAN_xxx should be changed into IFLA_CAN_DATA_xxx, in both=20
above eol comments.

Regards,

St=E9phane

--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
