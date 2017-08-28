From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 02/14] can: give structs holding the CAN statistics a
 sensible name
Date: Mon, 28 Aug 2017 09:25:05 +0200
Message-ID: <713e6bf9-5902-e138-598e-da5824cc1780@pengutronix.de>
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <20170802174434.4689-3-mkl@pengutronix.de>
 <92a0dacc-e1d2-435e-2bee-0ff0a20a655e@hartkopp.net>
 <361c5e96-0e89-ba24-4fbf-18087470bc69@pengutronix.de>
 <e3913ee0-93cc-2b22-dec2-75321a9b1ac7@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="iNRsL1Ja7DGg6a3NqqMic4awjVP0jSMBa"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:43007 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750797AbdH1HZN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 28 Aug 2017 03:25:13 -0400
In-Reply-To: <e3913ee0-93cc-2b22-dec2-75321a9b1ac7@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iNRsL1Ja7DGg6a3NqqMic4awjVP0jSMBa
Content-Type: multipart/mixed; boundary="5Ac18mxUogG8mPR1NGWcFRMpb1iiTvTPC";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de
Message-ID: <713e6bf9-5902-e138-598e-da5824cc1780@pengutronix.de>
Subject: Re: [PATCH 02/14] can: give structs holding the CAN statistics a
 sensible name
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <20170802174434.4689-3-mkl@pengutronix.de>
 <92a0dacc-e1d2-435e-2bee-0ff0a20a655e@hartkopp.net>
 <361c5e96-0e89-ba24-4fbf-18087470bc69@pengutronix.de>
 <e3913ee0-93cc-2b22-dec2-75321a9b1ac7@hartkopp.net>
In-Reply-To: <e3913ee0-93cc-2b22-dec2-75321a9b1ac7@hartkopp.net>

--5Ac18mxUogG8mPR1NGWcFRMpb1iiTvTPC
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 08/25/2017 07:32 PM, Oliver Hartkopp wrote:
> On 08/25/2017 03:08 PM, Marc Kleine-Budde wrote:
>> On 08/24/2017 02:58 PM, Oliver Hartkopp wrote:
>>> Naming structs and its instances identically is bad.
>>>
>>> On 08/02/2017 07:44 PM, Marc Kleine-Budde wrote:
>>>
>>>>    struct netns_can {
>>>>    #if IS_ENABLED(CONFIG_PROC_FS)
>>>> @@ -30,8 +30,8 @@ struct netns_can {
>>>>    	struct dev_rcv_lists *can_rx_alldev_list;
>>>>    	spinlock_t can_rcvlists_lock;
>>>>    	struct timer_list can_stattimer;/* timer for statistics update *=
/
>>>> -	struct s_stats *can_stats;	/* packet statistics */
>>>> -	struct s_pstats *can_pstats;	/* receive list statistics */
>>>> +	struct can_stats *can_stats; /* packet statistics */
>>>> +	struct can_pstats *can_pstats; /* receive list statistics */
>>                                 ^
>> Now I found out what that "p" originally means:
>>
>>> /* persistent statistics */
>>> struct can_pstats {
>>> 	unsigned long stats_reset;
>>> 	unsigned long user_reset;
>>> 	unsigned long rcv_entries;
>>> 	unsigned long rcv_entries_max;
>>> };
>>
>> \o/

I'll remove that comment then.

>>> If you really want to rename this stuff, what about this:
>>>
>>> struct can_pkt_stats *can_stats; /* packet statistics */
>>> struct can_rxl_stats *can_rstats; /* receive list statistics */
>>               ^^^
>> We're using rcv_list(s) instead of rxl in various other places.
>>
>> If we give the variables speaking names, the comments are obsolete:
>>
>> struct can_pkg_stats *can_pkg_stats;
>> struct can_rcv_list_stats *can_rcv_list_stats;
>>
>> We can remove the "can_" prefix of the variables in the struct
>> netns_can, as the struct already has the "can" in it.
>=20
> Yes. Good idea.

>> So the struct becomes:
>>
>>> struct netns_can {
>>> #if IS_ENABLED(CONFIG_PROC_FS)
>>> 	struct proc_dir_entry *proc_dir;
>>> 	struct proc_dir_entry *pde_version;
>>> 	struct proc_dir_entry *pde_stats;
>>> 	struct proc_dir_entry *pde_reset_stats;
>>> 	struct proc_dir_entry *pde_rcvlist_all;
>>> 	struct proc_dir_entry *pde_rcvlist_fil;
>>> 	struct proc_dir_entry *pde_rcvlist_inv;
>>> 	struct proc_dir_entry *pde_rcvlist_sff;
>>> 	struct proc_dir_entry *pde_rcvlist_eff;
>>> 	struct proc_dir_entry *pde_rcvlist_err;
>>> 	struct proc_dir_entry *bcmproc_dir;
>>> #endif
>>>
>>> 	/* receive filters subscribed for 'all' CAN devices */
>>> 	struct can_dev_rcv_lists *rx_alldev_list;
>>> 	spinlock_t rcvlists_lock;
>>> 	struct timer_list stattimer; /* timer for statistics update */
>>> 	struct can_pkg_stats *pkg_stats;
>>> 	struct can_rcv_lists_stats *rcv_lists_stats;
>=20
> Agreed :-)
>=20
> So it would look like this then:
>=20
> diff --git a/net/can/proc.c b/net/can/proc.c
> index 83045f00c63c..559fca8035aa 100644
> --- a/net/can/proc.c
> +++ b/net/can/proc.c
> @@ -77,14 +77,14 @@ static const char rx_list_name[][8] =3D {
>=20
>   static void can_init_stats(struct net *net)
>   {
> -	struct s_stats *can_stats =3D net->can.can_stats;
> -	struct s_pstats *can_pstats =3D net->can.can_pstats;
> +	struct can_pkg_stats *pkg_stats =3D net->can.pkg_stats;
> +	struct can_rcv_lists_stats *rcv_lists_stats =3D net->can.rcv_lists_st=
ats;
>=20
> Right?

ACK

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--5Ac18mxUogG8mPR1NGWcFRMpb1iiTvTPC--

--iNRsL1Ja7DGg6a3NqqMic4awjVP0jSMBa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlmjxVIACgkQHv7KIOw4
HPYkOwf/YQwtFZTRHQb2mfDS27dGPNp7KBKI7Kt40ec77Pn2r7DttP9EyEqKY8A4
6wOXGXQIFwiI5Hyx0G/oHtbOEJ5PgWQlHkyFcvN+KHEaSLZN6u7ljboaf0Qesech
/psjSv9H1i4PykXoxLbAdxF3BCY7bIq8QmuUEtbxE3wfPDsYLNxvGYQkRb0MMtrK
a9JYMttTQdLlfAZCOKNkyEg24PyiGUA5OffT2ZM4u4kNOtiVs69EfoPpnq+ARuwI
ySQW2KMzHnNkpZGfYejmjFEcRTphk8Lo4caxM2k8LhOI0xOg7x9v5rvRPoI0MGSD
TwJyhuW7L9QFda5WLRQuN2lpZaU2Sg==
=kxmi
-----END PGP SIGNATURE-----

--iNRsL1Ja7DGg6a3NqqMic4awjVP0jSMBa--
