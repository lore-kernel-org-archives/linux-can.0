From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 02/14] can: give structs holding the CAN statistics a
 sensible name
Date: Fri, 25 Aug 2017 15:08:17 +0200
Message-ID: <361c5e96-0e89-ba24-4fbf-18087470bc69@pengutronix.de>
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <20170802174434.4689-3-mkl@pengutronix.de>
 <92a0dacc-e1d2-435e-2bee-0ff0a20a655e@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="EAx739b9ppjGkouSmXP15BuFttuL8d4xh"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:38289 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754456AbdHYNIX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 25 Aug 2017 09:08:23 -0400
In-Reply-To: <92a0dacc-e1d2-435e-2bee-0ff0a20a655e@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EAx739b9ppjGkouSmXP15BuFttuL8d4xh
Content-Type: multipart/mixed; boundary="fQqVo31gigfT4Ng8LtAFOarIQmai0cmuL";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de
Message-ID: <361c5e96-0e89-ba24-4fbf-18087470bc69@pengutronix.de>
Subject: Re: [PATCH 02/14] can: give structs holding the CAN statistics a
 sensible name
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <20170802174434.4689-3-mkl@pengutronix.de>
 <92a0dacc-e1d2-435e-2bee-0ff0a20a655e@hartkopp.net>
In-Reply-To: <92a0dacc-e1d2-435e-2bee-0ff0a20a655e@hartkopp.net>

--fQqVo31gigfT4Ng8LtAFOarIQmai0cmuL
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 08/24/2017 02:58 PM, Oliver Hartkopp wrote:
> Naming structs and its instances identically is bad.
>=20
> On 08/02/2017 07:44 PM, Marc Kleine-Budde wrote:
>=20
>>   struct netns_can {
>>   #if IS_ENABLED(CONFIG_PROC_FS)
>> @@ -30,8 +30,8 @@ struct netns_can {
>>   	struct dev_rcv_lists *can_rx_alldev_list;
>>   	spinlock_t can_rcvlists_lock;
>>   	struct timer_list can_stattimer;/* timer for statistics update */
>> -	struct s_stats *can_stats;	/* packet statistics */
>> -	struct s_pstats *can_pstats;	/* receive list statistics */
>> +	struct can_stats *can_stats; /* packet statistics */
>> +	struct can_pstats *can_pstats; /* receive list statistics */
                               ^
Now I found out what that "p" originally means:

> /* persistent statistics */
> struct can_pstats {
> 	unsigned long stats_reset;
> 	unsigned long user_reset;
> 	unsigned long rcv_entries;
> 	unsigned long rcv_entries_max;
> };

\o/

> If you really want to rename this stuff, what about this:
>=20
> struct can_pkt_stats *can_stats; /* packet statistics */
> struct can_rxl_stats *can_rstats; /* receive list statistics */
             ^^^
We're using rcv_list(s) instead of rxl in various other places.

If we give the variables speaking names, the comments are obsolete:

struct can_pkg_stats *can_pkg_stats;
struct can_rcv_list_stats *can_rcv_list_stats;

We can remove the "can_" prefix of the variables in the struct
netns_can, as the struct already has the "can" in it.

So the struct becomes:

> struct netns_can {
> #if IS_ENABLED(CONFIG_PROC_FS)
> 	struct proc_dir_entry *proc_dir;
> 	struct proc_dir_entry *pde_version;
> 	struct proc_dir_entry *pde_stats;
> 	struct proc_dir_entry *pde_reset_stats;
> 	struct proc_dir_entry *pde_rcvlist_all;
> 	struct proc_dir_entry *pde_rcvlist_fil;
> 	struct proc_dir_entry *pde_rcvlist_inv;
> 	struct proc_dir_entry *pde_rcvlist_sff;
> 	struct proc_dir_entry *pde_rcvlist_eff;
> 	struct proc_dir_entry *pde_rcvlist_err;
> 	struct proc_dir_entry *bcmproc_dir;
> #endif
>=20
> 	/* receive filters subscribed for 'all' CAN devices */
> 	struct can_dev_rcv_lists *rx_alldev_list;
> 	spinlock_t rcvlists_lock;
> 	struct timer_list stattimer; /* timer for statistics update */
> 	struct can_pkg_stats *pkg_stats;
> 	struct can_rcv_lists_stats *rcv_lists_stats;
>=20
> #if IS_ENABLED(CONFIG_CAN_GW)
> 	/* CAN GW per-net gateway jobs */
> 	struct hlist_head cgw_list;
> #endif
> };

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--fQqVo31gigfT4Ng8LtAFOarIQmai0cmuL--

--EAx739b9ppjGkouSmXP15BuFttuL8d4xh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlmgIUEACgkQHv7KIOw4
HPZ7Vgf7B8cQznPJjtQoQ7oDQvTM5bdUznfwJ5qUtsOmWgzrmV/oWt9zDU3j09yq
/C4P+BIZYuc4rJf7xgHeT4Di6TcSNQIk0Y/+5R2q1OamGNo0jkumpcQDNv+wM2OX
mW9lEHVeLhuXSZwgSphpZkbZ3YOPfV4lnqEUrmiL+/vZKW+PiURZxE/HtBnuVeJu
0vTQMw0ajppw2fwisBvAi3VGIHKpUS7ILkAVgi/3buHflUt0zTlGvmm/4w430bqM
RLKlCjpFNP70Nvq7CwENz6kWggomOBnqpW1vDbtMXgEwZzDf5aCo2jDDtaloNlEP
UpM2B0s4VzQ6cZgirO/KvGaJ4Rkb8Q==
=EF3h
-----END PGP SIGNATURE-----

--EAx739b9ppjGkouSmXP15BuFttuL8d4xh--
