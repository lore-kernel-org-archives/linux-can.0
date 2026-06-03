Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172CE23D7FF
	for <linux-can@vger.kernel.org>; Wed,  3 Jun 2026 00:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780447411; cv=pass; b=juLhV4PI1yaJrOWO+GL1vRYPtmPA40zmfTQ8XcWnf2XiRzI3IbiJfhIAuTwuHJo890u1X65VxBTVLXImRpYvo9g0brzM94oPD0v3CDH0qyJBKb0h3DShloDd2rURyxYNhTZys2Ze1GsrRI+z6ngG+LIqlRwI6u8cDUmchaZpESQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780447411; c=relaxed/simple;
	bh=eXlPzJlmUX16orKo8VrfXZmXFclPCCHVVfUpU8AR1aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J6NSVoEANBSTS7DEoVOvwQu04q+9aGs5mPcJBP+fhaSXGHWVGh6tDVs+fNSpdNWuMw9mxUUn2s8Tjq1JEHVH2FBV3yXL/BLiGkDwd62hK3fixB9iTfE1Q2IP9NMd0lsPDHp/L2BxvytPHAN0A7Fy+GX1NV3ml1kVGwKZnkRqhFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5Nhht5i; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5Nhht5i"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6896c54a7easo977639a12.3
        for <linux-can@vger.kernel.org>; Tue, 02 Jun 2026 17:43:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780447408; cv=none;
        d=google.com; s=arc-20240605;
        b=QO1gcNP/R4ybVkXO3R+L/3h12BjTIIvz0VeCG/eTNQ2+HpPW8SI8Px4SpzhOHECN5p
         mLo3KeD97fez12kKT6Pc7NGYRIdiE3pz/qzTpjKWkpPkVOhun8lbQx2GrhDLjgykoeTW
         1KFnoDl6kn4X/P8c7X4gzKOw6pNmPCLoj6xZZO048XuBCgzjAZdKeduWhnFLbBtS7+T7
         hPZ1yPIoUV/m3KMPmYQytULAHhxqCDpd1YG5Q3GWJ5QpNlbap+//Mz42i6LLyv/hcwBY
         Lb9YMnZcLYgFlvskeyPZ0F4iFkY2GlCevwiIZPhJWoVQmc7KxyQqiW1VyOuMawqaYDfo
         93jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4jpvdYmaA+cZI0xSbj3UsROS3FB9s5X7rfA1BJRjmjY=;
        fh=3iytm150aLZKfjJdwP8oeAFYFcdhTw4Q1nsWvvXyqzE=;
        b=Sffb3pr3JIh8eeTX2svgI/qI6mYc9x3QOnenlkTjRQJ4+BfDt5mlneCKzEkVpQ47Nt
         MVumgi4B9U9ikT1oJGfBDebZK3y70UufT5wA1JJzSMLPfrJdYaKreSwcnq2yzAVDzEna
         p7wme5gJZfOnpGm8B2DcdPtkeDHQog3brvAQHxJp2vXh/TRdVkE8ibu7EFkH6aQAgFoc
         NbC+esbPHAy87/MPpRWHNGiy2db7gZ2mF6Y/Ykvf7V0l0cLlfXomURn6oLySRm+a+W/l
         cTIAFloRlCYG1+DtQNTukNj5GQJAc1FrDgxr83wHy7ifoS+tH6L7DEJRjfrBgbGZyZar
         /jsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780447408; x=1781052208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jpvdYmaA+cZI0xSbj3UsROS3FB9s5X7rfA1BJRjmjY=;
        b=k5Nhht5ibgkscdxAo6W35iKt4/PrM8aC9yUlv6NTteJYaDGTl8So7CAiMjOiBjC/fj
         fKrEVgr0OWc9IG4OiAMjFCymwggKLQZCM45LojOFwyjh0nnijnDTD14L05IF+zSIdHzd
         mw4DQb1b/pyu5oWUCLBXmgZGuGeLcQn0mctV/Kc/Kiw/BeixE1beitCJdJCRa+80Gf9v
         B8CFdKnRbfy1SgajqiVyj7JDJQihvo37ScU/w3p+GQJYMJz4l/Eun7rRj7wB9ou/vYem
         wTULy5UivFe1EQD7nM8dk1mhTV3Ty1fd+AAUdL6fe6GZqO9YZ/WkHUEjPZK+D3fZoB3H
         jpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780447408; x=1781052208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4jpvdYmaA+cZI0xSbj3UsROS3FB9s5X7rfA1BJRjmjY=;
        b=Af0vsI4HpIhrxVBf8zPx4HTLLbJH2EQ4mItZ4NDgF/fclDUhoIeY9BF3KpNTzlM/aV
         8GOADz+YFNIK154pEVi6vPViRSdndP8JyAlv7iDq5CcJ3wUrdNG3bFAWDiQ4J5+USRpv
         byVCTDUfhP07KcqZauxHiE7Mr/PvtspkB8/Le+doroHIhWQGQrR0ylTOUcESnfz+vx2E
         N3GEqPARI2e+ngYZffU1tZYN6YlsnjyvgxmueA+KWRr0qhulLWEdlRb3aFCEoAn0ADKd
         JYgFNTiigsC/DHQuE4vdd2vLm4IXnzGJVSPALyJSjT3qQpRk7dkop9r6AJC/1rkL2ZOK
         e+zA==
X-Gm-Message-State: AOJu0YxS5gck2315AlY5spQAj3IfL5nh97k8hv5PuFd5tW82PasuD2g2
	5va2zhLw6QYmlzunTuAcLeeZsBfuy41b+4G6d9dEuuWpAcJjcAvEJ6/7RBssRzx/DxMGnoAkWcB
	QxgM6TZlDXbAUmrL7O86Ut6HiV/Klf/Y=
X-Gm-Gg: Acq92OHib3LCTAazah5/3VLMUXhUzvVyZCsKISqrdKu1luE08DT+iB3U1D0rzxd7eh7
	/kJtlZqd7p2AbNUD3yY9dGznOLzRuKrf0SALZWTNkdKBdWKQQK9v44G2GIMTaDOlCvbO2RzPoSK
	kX3ADp37HEA6kyeGRitRGEd6N8qmMhMj9tU7KgeHdhw8hi3PL5o2GGzMjflrBFVOi1uOPnyQZWM
	ydp6Pt9B95C1CKN32taLGBFW5S0wDL9b20UIn0aA2r+0qUdqYg7tiVXXBbczofsAV/YxpWQItVG
	UiJGlL8W8Ag4CkNJSUsw7AAN2CMpJgFVXrLe8rkMdvD82dBGwGxz12kT1/KLW4BVs1eHVx7JNO5
	9Orm9CYfCuVxhL2ooAngTQ0R/9jrZrtE+yooRb6FQWsN34npkkKjubv8QQG6kGdSqVZOu
X-Received: by 2002:a05:6402:27c6:b0:68a:e054:5b72 with SMTP id
 4fb4d7f45d1cf-68e7234890fmr364848a12.19.1780447408373; Tue, 02 Jun 2026
 17:43:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602223431.17672-1-rosenp@gmail.com> <36da6192-a69e-4ab8-90f6-590f620ecc5f@kernel.org>
In-Reply-To: <36da6192-a69e-4ab8-90f6-590f620ecc5f@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 2 Jun 2026 17:43:16 -0700
X-Gm-Features: AVHnY4I8kd0-VEgIUuwO044sR2XaPtAvngH1tDopWNo3whojGds4rDa2vj0yKhM
Message-ID: <CAKxU2N86OYiXvtw=n5gNAtRzYeqf8UKA-Y=NTNoXMza70hHnjg@mail.gmail.com>
Subject: Re: [PATCH] can: mscan: replace in_8/out_8 with ioread8/iowrite8
To: Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, chleroy@kernel.org, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 5:29=E2=80=AFPM Vincent Mailhol <mailhol@kernel.org>=
 wrote:
>
> On 03/06/2026 at 00:34, Rosen Penev wrote:
> > Mechanical conversion of the ppc4xx-specific in_8/out_8 accessors and
> > the setbits8/clrbits8 macros to the generic ioread8/iowrite8 helpers
> > for portability.
> >
> > Add HAS_IOMEM as these functions need it.
> >
> > Add COMPILE_TEST as a result. This can be built anywhere now.
> >
> > Assisted-by: opencode:big-pickle
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
>
> I left a comment for a potential extension of the patch, but it is ok as-=
is.
>
> Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
>
> > ---
> >  drivers/net/can/mscan/Kconfig |   3 +-
> >  drivers/net/can/mscan/mscan.c | 143 +++++++++++++++++-----------------
> >  2 files changed, 73 insertions(+), 73 deletions(-)
> >
> > diff --git a/drivers/net/can/mscan/Kconfig b/drivers/net/can/mscan/Kcon=
fig
> > index dfe6bd9947bb..ef3a99b3d3db 100644
> > --- a/drivers/net/can/mscan/Kconfig
> > +++ b/drivers/net/can/mscan/Kconfig
> > @@ -1,6 +1,7 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  config CAN_MSCAN
> > -     depends on PPC
> > +     depends on PPC || COMPILE_TEST
> > +     depends on HAS_IOMEM
>
> It seems to me that following your changes, it should also now become
> easy to add COMPILE_TEST to config CAN_MPC5XXX.
I'll look into this.
>
> mpc5xxx_can.c has a couple of unused headers, after removing those, I
> could compile test it!
>
> These are my local changes:
>
> ----8<----
> diff --git a/drivers/net/can/mscan/Kconfig b/drivers/net/can/mscan/Kconfi=
g
> index ef3a99b3d3db..9bffd91ea418 100644
> --- a/drivers/net/can/mscan/Kconfig
> +++ b/drivers/net/can/mscan/Kconfig
> @@ -13,7 +13,7 @@ if CAN_MSCAN
>
>  config CAN_MPC5XXX
>         tristate "Freescale MPC5xxx onboard CAN controller"
> -       depends on (PPC_MPC52xx || PPC_MPC512x)
> +       depends on PPC_MPC52xx || PPC_MPC512x || COMPILE_TEST
>         help
>           If you say yes here you get support for Freescale's MPC5xxx
>           onboard CAN controller. Currently, the MPC5200, MPC5200B and
> diff --git a/drivers/net/can/mscan/mpc5xxx_can.c b/drivers/net/can/mscan/=
mpc5xxx_can.c
> index 0080c39ee182..759efb71d843 100644
> --- a/drivers/net/can/mscan/mpc5xxx_can.c
> +++ b/drivers/net/can/mscan/mpc5xxx_can.c
> @@ -9,8 +9,6 @@
>   */
>
>  #include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/interrupt.h>
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
>  #include <linux/netdevice.h>
> @@ -18,11 +16,6 @@
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
> -#include <linux/of_platform.h>
> -#include <sysdev/fsl_soc.h>
> -#include <linux/clk.h>
> -#include <linux/io.h>
> -#include <asm/mpc52xx.h>
>
>  #include "mscan.h"
> ----8<----
>
> Et voil=C3=A0 ! Both CAN_MSCAN and CAN_MPC5XXX can now be compile tested!
drivers/net/can/mscan/mpc5xxx_can.c:22:10: fatal error:
'sysdev/fsl_soc.h' file not found 22 | #include <sysdev/fsl_soc.h> |
^~~~~~~~~~~~~~~~~~

drivers/net/can/mscan/mpc5xxx_can.c:376:2: error: call to undeclared
function '_memcpy_fromio'; ISO C99 and later do not support implicit
function declarations [-Wimplicit-function-declaration] 376 |
_memcpy_fromio(&saved_regs, regs, sizeof(*regs)); | ^

needs more work.
>
>
> >       tristate "Support for Freescale MSCAN based chips"
> >       help
> >         The Motorola Scalable Controller Area Network (MSCAN) definitio=
n
>
>
>
> Yours sincerely,
> Vincent Mailhol
