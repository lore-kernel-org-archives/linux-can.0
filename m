Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABCF47CC71
	for <linux-can@vger.kernel.org>; Tue, 16 Jun 2026 18:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781634358; cv=none; b=Hq7lqDWNmFFvtM1mwuqOIFLpBpjdzIfgiSPqXuE5h3oKxfrzFlZwB96PBzcayNL9/Fr9dDfIJXcoBNn3TmQpQABdenRaXuCogdumLcpK8zVw1sZniTyHkcJq+i0xj3gLydzkpZ+CwqV5jKNQ5wErR1G+BYOU46smPG8eOj87IY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781634358; c=relaxed/simple;
	bh=ZjvKw+nv+EfzNhnXcVTNH9GVXNuzmw/pSRMAqExXlEA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tjyhIScZzXkEf36dgFE5N29J8wn66wbymj+z3VYFv97StQ+Tq6I/Id74FmNmdI/7JnmisSaRvCOzTkhHWc5ao34vKytW94UO60qsBg+BcKQaM6K4ruvRufk3SApwE4l3pyIc2xe4HrcGhOyR0XLf3BJUrDwLor7x0EG8nWBD8+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=boBLu1Bh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="boBLu1Bh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6AB31F00A3D;
	Tue, 16 Jun 2026 18:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781634357;
	bh=PYiRqhCf8uhnynMdh4zYJm3HZ1p53UDY9BVtbn7+Bas=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=boBLu1Bhuo/3P+KW/qg9455D7myqQ1Nvgqz/yyHWen/hMzX1nUl5ktZ5y+zshkDkT
	 Jmqrv+QL11GHhB+2kudhncY5VShyNNDNExLyV5s+2f16niMVwtqKGQBavhXeygvFim
	 ydkuL8z+nXiYwyJdREMyR59I5ulHK/Oi9qQJwRIsReDlzfqsPcJoTWpqXiTLCKjCNS
	 KBboleek7MWkPau7FXXxUvbCP87f4J1aV3ZGwEzHypA1ndvXvNbMZmecKv5AKNW5tt
	 iWgKrMHYumOzm9i4hcN7bUZBgaUCu2bUWdkOeHH3xn3NXLBW5jaD57VC5zi1YaPmWN
	 4cj303KyIXvdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] can: peak_usb: fix double free of transfer buffer
 on URB submit error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maoyi Xie" <maoyixie.tju@gmail.com>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org
In-Reply-To: <178163373110.2507866.216458825145756798@maoyixie.com>
References: <178163373110.2507866.216458825145756798@maoyixie.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 18:25:56 +0000
Message-Id: <20260616182556.D6AB31F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] In-flight TX URBs and their transfer buffers are permanently leake=
d when the CAN interface is brought down.
- [High] If `peak_usb_start()` fails to allocate the full set of TX URBs, u=
ninitialized contexts cause a NULL pointer dereference in `peak_usb_ndo_sta=
rt_xmit()`.
--

commit 940b179b096bd59f1b3c9ac845bb1de2207ae9fa
Author: Maoyi Xie <maoyixie.tju@gmail.com>

can: peak_usb: fix double free of transfer buffer on URB submit error

This commit removes a redundant explicit free of the transfer buffer in
the error path of peak_usb_start() because usb_free_urb() already handles
it when URB_FREE_BUFFER is set.

Closes: https://lore.kernel.org/linux-can/178159320216.2154888.169534517937=
88581739@maoyixie.com/T/#u
Cc: stable@vger.kernel.org

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/c=
an/usb/peak_usb/pcan_usb_core.c
> index cf48bb26d46d2..079b23dd74f04 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> @@ -470,7 +470,6 @@ static int peak_usb_start(struct peak_usb_device *dev)
>  				netif_device_detach(dev->netdev);
> =20
>  			usb_unanchor_urb(urb);
> -			kfree(buf);
>  			usb_free_urb(urb);
>  			break;
>  		}

[Severity: High]
This is a pre-existing issue, but does this driver leak in-flight TX URBs
and their transfer buffers when the CAN interface is brought down?

When the interface is stopped, peak_usb_ndo_stop() calls
peak_usb_unlink_all_urbs() to clean up. This function iterates over the
pre-allocated TX URBs but explicitly skips freeing any URB that is
currently in-flight:

drivers/net/can/usb/peak_usb/pcan_usb_core.c:peak_usb_unlink_all_urbs() {
        if (!urb ||
            dev->tx_contexts[i].echo_index !=3D PCAN_USB_MAX_TX_URBS) {
                /*
                 * this urb is already released or always submitted,
                 * let usb core free by itself
                 */
                continue;
        }

        usb_free_urb(urb);
        dev->tx_contexts[i].urb =3D NULL;
}

While usb_kill_anchored_urbs() will abort the submitted URBs and cause the
USB core to drop its submission reference, the driver's original allocation
reference is never dropped because of the continue statement above.

When the interface is subsequently restarted, peak_usb_start()
unconditionally allocates new URBs, overwriting the context pointers
and permanently leaking the old URBs.


[Severity: High]
This isn't a bug introduced by this patch, but could this code path cause
a NULL pointer dereference in peak_usb_ndo_start_xmit() if the driver fails
to allocate the full set of TX URBs?

Later in peak_usb_start(), if memory allocation fails for a TX context after
at least one context is successfully allocated, the driver issues a warning
and proceeds:

drivers/net/can/usb/peak_usb/pcan_usb_core.c:peak_usb_start() {
        /* warn if we were not able to allocate enough tx contexts */
        if (i < PCAN_USB_MAX_TX_URBS) {
                if (i =3D=3D 0) {
                        netdev_err(netdev, "couldn't setup any tx URB\n");
                        goto err_tx;
                }

                netdev_warn(netdev, "tx performance may be slow\n");
        }
        ...
        return 0;
}

The unallocated contexts retain a NULL urb pointer and their echo_index=20
is set to PCAN_USB_MAX_TX_URBS, marking them as available.

However, peak_usb_ndo_start_xmit() only stops the netdev TX queue when the
total number of active URBs reaches PCAN_USB_MAX_TX_URBS. If the number
of concurrent transmissions exceeds the number of successfully allocated
contexts, it can select an unallocated context and blindly dereference it:

drivers/net/can/usb/peak_usb/pcan_usb_core.c:peak_usb_ndo_start_xmit() {
        if (!context) {
                /* should not occur except during restart */
                return NETDEV_TX_BUSY;
        }

        urb =3D context->urb;
        obuf =3D urb->transfer_buffer;
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178163373110.250786=
6.216458825145756798@maoyixie.com?part=3D1
