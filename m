From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 0/7] R-Car D3 (r8a77995) CAN support
Date: Fri, 17 Nov 2017 17:17:55 +0100
Message-ID: <20171117161754.prbpvjwnsbvo7koz@tetsubishi>
References: <1510915289-15059-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="coerma7qxs32s5ev"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1510915289-15059-1-git-send-email-ulrich.hecht+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulrich Hecht <ulrich.hecht+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, chris.paterson2-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, ramesh.shanmugasundaram-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org
List-Id: linux-can.vger.kernel.org


--coerma7qxs32s5ev
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Here's CAN and CAN FD support for the R-Car D3. This is a by-the-datasheet
> implementation, with the datasheet missing some bits, namely the pin map.
> I filled in the gaps with frog DNA^W^W^Wby deducing the information from
> pin numbers already in the PFC driver, so careful scrutiny is advised.

Did you have a chance to test one of the configurations?


--coerma7qxs32s5ev
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAloPC6oACgkQFA3kzBSg
KbaPdRAAgyZlc6q+G62VlXUyIQ9wX9/5BK5C6HouYMgfPwpkqsrqjPwqOEaSD5CP
6NVjuIj5LcigYh0r9XW8iVTmoNPmAZAeEiYzaFIqdT+4X8tYOFiJ1UbE65K8v2OP
6ZZ5bhkAxJH3d07gGdjDwixZWiyn4A15KYqT50UZH7MGELCVjvCGdHJnaLXkmiG6
gxmFmb9+YIPcNJOYSHiffFBXtlEcyw1tpg0g5a4Ad6ddOZLUfN6N3rYYUzU7X3uf
DZ9w/46CYYwfkv5zFjuctX4S5tNKSuzLGgHBxBHZwsruDlfAUXQXq2AWlUavG6u/
NgyNolHGJ4oBnPKzS8nDV0AerhSGPxLNOOeUx3k3YYaUIsxrDvnh3+RlJ0Y5cz+m
sVzgStaclAX1DOLjG3KYxpNAeZt2S7kJX/GywGd469SLr2nRERxDRCPF84dyegoV
YVni07CFNSnJap4TvLTavbVxWWwIYQYwIaOYCy3u2KibNVZJUqY4UJ88AVR+MPBd
d347C8mNFDhpd/FYV+nN0bOR5+gmcXgOHaIlMH1p/l4dPLgIU8IEYJ7OAvnOSrgU
5dcjR6mfHerkOnlVrkNfJlI+kYyeFyvVzhmb2ZiL8eOJ07OkYyLzZzcJhFYgRVpO
zQTADvaWWVH/4fI5sThUFI3C6DQJeZZZMREaPHRoBR3uDpyqxjI=
=MQGL
-----END PGP SIGNATURE-----

--coerma7qxs32s5ev--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
