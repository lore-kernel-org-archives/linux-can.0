Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2A513C908
	for <linux-can@vger.kernel.org>; Tue,  8 Sep 2026 00:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788826781; cv=pass; b=rrQKNTGH8ojIbFYyrwmmfiboSmcyli9j8cOk04VEgpFtatHnJiGxn51KK5viVgZyx5Uos3YVwjY+SnqFady5GGVFOPnsfq6LRtJvL6/+ZKSAlbrOub4d1RXHPRTdpBF8nyZc12IRSSjb4j7HxkcMOqlGwUSv/8DIkq1Lyx8pxR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788826781; c=relaxed/simple;
	bh=+M6TmmP4+OOvdohspRXB30W4tZMbf9Y2hUaFjmgIkWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nm2OSg8mFxFmNdjMSC4YTVGlg0vM6TfHyNnlUAUtZvw3dCXpf2v5dziNMjgEE3vv7b/dPC5qXNCWLpXVCeXkTcbKCXp0WSk8eFVntxGXXXTvPJBimWkusiLKqmbE9G9Sl6e4oRr6sTU/ljVNuJKdWtQyFgH+2U8OjhuoN7h0IT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=VxwXwTCP; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="VxwXwTCP"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84e0688b7e8so3060423b3a.1
        for <linux-can@vger.kernel.org>; Mon, 07 Sep 2026 17:19:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788826779; cv=none;
        d=google.com; s=arc-20260327;
        b=IZILOkeGRhjLx/0qZMmwRZcQUzeEIctTYwNf56JptmkjAFbmNM6yKjz6d2Jhyagq2R
         HZeQwEszWTQDad7ZiEcXIe7NWDSfdG9o4lc2PLPMgEAA6WV7L3NERrfjUxzaEgxUVv6B
         OC6yy+ymfxSnsoq2FW3Gn1RJ4TXB63cZTwRa7oRkKjHN2GMGfI+7ziIwEl1eQPEq6Ysy
         4GyIcuFaXTPjW2cMiIU0ruAf6BgQ+W7okgEQBZbxPP/n1KaV6xl4Hui+Q+w4vEt/l9j2
         BCObG8/wJ3Hvy3hVhDA/euHgtjkcZiS2JLyB+6NIwUesWYtzgE0y7P1iBeunDzS7RNka
         usTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cRckfZ16+zJTyIQnioB8gFSUQtruekle/Igl+7aOJKc=;
        fh=TYYFr4DO5KcftEJ1fefZ3qG3npr99q6YsLoKWcGL8OI=;
        b=WMMZYLNEAguP6oM5KSQX96zdVLfB3OM5SGrLRaUH4GC1JOVy+fX1ObaoOx3oQ2jAME
         wOQg24b3j0MdkjPoBHJfU6Hx0TiWpSGzSQk8Nm3K8G8IXOVtOeqWfy6n0QbUEybVIvY7
         gy253MyWyGbWvWP1xe/UGpG4tVf5r+rgB3ZufGSi9tlxlm8bWNYfb2mGWvh71uSzX137
         eQxeMYZqau74GGV315ESzaoXF+5E3ysxzqOUBGMCu8cAOq1aySWtTrOyup5fBlN4KTG3
         NROFGhjFR8H/aH5vuiAJg3Seu3b6klZYN3sL4rYtG62R4x28xwKZX1luM1dmMjBP0E3c
         5Lqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1788826779; x=1789431579; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cRckfZ16+zJTyIQnioB8gFSUQtruekle/Igl+7aOJKc=;
        b=VxwXwTCPoehmO4Jb2gifBibhGu9R0BJ7XUo86B6Yd9SXmACRaD8f3NQOX1ado6pck6
         R4ZW0564HD4gW3Z6wwUAdgSEzKpv3d3ixY+h01cvsZmkEn1/7oSKR0WLAudLtAvFWX9V
         notddt9+dV/m75YzEQS+JtI2ROOcwKuFFjVV/Q4FLrZ4l1GlradIg7pYY+U8zjquFMMz
         cv87+1U8HdNEVUkQDJ6CDK29/UkCd1qP1TFC3TRPlM1W+SpEJXkhncTnyaJnpWLJIaVM
         dJ2cdCWwRMqFNQseDU2Gq0oZq9lIXKU8Hu2AItxpwiGnqcw3xLgbJmcFBi7v/mFvxOfH
         bfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788826779; x=1789431579;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cRckfZ16+zJTyIQnioB8gFSUQtruekle/Igl+7aOJKc=;
        b=Rt+Ox5RiFQEDTe03o2EwDYc72LESNhpuelV+pb2fGC6jc0AbuZdUmOz6LXrUkEzxxl
         e4wiMZBdEQ+6RZqbBNTQWSU8+8L6YKU/Y2/NYL0RdhN1TBAXmwz/xqaHcj5Jw/j4LhjP
         I4oNxRJEbaMlSv3NKdlJCUWxciKT1WK6929um2QZAvN/1Bw4haMzvsN2fXaV8lw8gjfB
         K+86hWDYKzKU0a5Pp/0mfsxkANLPpXquBT/xqd2Cj6xSm3P5SgZg6PeFYo7BA0wKSq9U
         hFmjsmYD+TmHkOHJLw/NerN8rmilRBo5U3PGiMq+6evU/HlHpgfAtZsuMQ5XbKt24Jhi
         LKWw==
X-Gm-Message-State: AFuF++kDj8UXwXZV3vnhWPHuVo7oHGimcpXaIKk7WihyXTAEWUl0H59O
	oHti/l5dcSRj9BCLvpIIn04+z5ZAOEkNjdtVVA0BZN1yMp7qPZgqwa1+aE0i80F5r44f3Om9k+I
	WvH7FtrtUuah6Pl/r/2tGJtUndb2XeiQBqSWty5E/z2TdlugfGjMFLg==
X-Gm-Gg: AYBFou1JXay6sMmDpj+DMnMz+IkvDtgNmAZjkuZ8xJxA6Zv8jj9cxyQzNk4px4Xqnup
	x1M+mSoX8GmBTxQPYmn5LoKzObUFl9q2OJ8+skz77hxroyvc3z/hBTj9B1saRaxSSIt662Wn7mj
	TjOBDO1nmDKDqF66laQx8bAZYVhYq/LkC0GyxHykWrmI52pU6I8imHPaO3ebhKKLhcNMYycEXzn
	axg6hwYPgh0VUvXmVoHhH6bGvjrhKE5+0bXM7xJUeJB+nFdJh9sqdRDnFN1gddhxpMd2ldEidSx
	wX3rSv4m3a3WD0oh/czeUApisU7cw25qZ177i0VXpVPIwbsq7RW+aPLpkXocRhlDE1H6xmc+P3U
	wPx8uPn4xz4wnnXPnQhiupxb+apiWPg==
X-Received: by 2002:a05:6a00:438e:b0:857:72f8:dc98 with SMTP id
 d2e1a72fcca58-86169b70c5bmr38586874b3a.25.1788826778128; Mon, 07 Sep 2026
 17:19:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902110611.2426535-1-anol@kvaser.com>
In-Reply-To: <20260902110611.2426535-1-anol@kvaser.com>
From: Farhad Alemi <farhad.alemi@berkeley.edu>
Date: Mon, 7 Sep 2026 17:19:26 -0700
X-Gm-Features: AcwNN1VeBrIosVzOJBehoR_4gwOUBytCu5SJHMFbiKIahflOkuwPEI70PFWpMjA
Message-ID: <CA+0ovCi_HLyMVaCDR94JtBKJx+aSosHw5R1A7Q==WfS46_YUpQ@mail.gmail.com>
Subject: Re: [PATCH] can: kvaser_usb: fix potential crash in probe
To: Anton Olsson <anol@kvaser.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Jimmy Assarsson <extja@kvaser.com>
Content-Type: multipart/mixed; boundary="000000000000addf18065aedb05c"

--000000000000addf18065aedb05c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Upon our run, the patched kernel (this patch on 28924df2a08f) no
longer panics on the attached reproducer.

Tested-by: Farhad Alemi <farhad.alemi@berkeley.edu>

On Wed, Sep 2, 2026 at 4:06=E2=80=AFAM Anton Olsson <anol@kvaser.com> wrote=
:
>
> The leaf driver does not return any errors when no clock configuration
> can be found, and instead it emits a null-check warning. Add default
> cases to return an error when no matching clock configuration can be
> found.
>
> Signed-off-by: Anton Olsson <anol@kvaser.com>
> Reported-by: Farhad Alemi <farhad.alemi@berkeley.edu>
> Link: https://lore.kernel.org/linux-can/20260828-sassy-ammonite-of-focus-=
b2f17c-mkl@pengutronix.de/T/#t
> Reviewed-by: Jimmy Assarsson <extja@kvaser.com>
> ---
>  drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/n=
et/can/usb/kvaser_usb/kvaser_usb_leaf.c
> index a876c7819b81..2091de2e4f8f 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> @@ -747,8 +747,8 @@ static int kvaser_usb_leaf_send_simple_cmd(const stru=
ct kvaser_usb *dev,
>         return rc;
>  }
>
> -static void kvaser_usb_leaf_get_software_info_leaf(struct kvaser_usb *de=
v,
> -                                                  const struct leaf_cmd_=
softinfo *softinfo)
> +static int kvaser_usb_leaf_get_software_info_leaf(struct kvaser_usb *dev=
,
> +                                                 const struct leaf_cmd_s=
oftinfo *softinfo)
>  {
>         u32 fw_version;
>         u32 sw_options =3D le32_to_cpu(softinfo->sw_options);
> @@ -777,6 +777,8 @@ static void kvaser_usb_leaf_get_software_info_leaf(st=
ruct kvaser_usb *dev,
>                 case KVASER_USB_LEAF_SWOPTION_FREQ_32_MHZ_CLK:
>                         dev->cfg =3D &kvaser_usb_leaf_m32c_dev_cfg_32mhz;
>                         break;
> +               default:
> +                       return -ENODEV;
>                 }
>         } else {
>                 switch (sw_options & KVASER_USB_LEAF_SWOPTION_FREQ_MASK) =
{
> @@ -789,8 +791,11 @@ static void kvaser_usb_leaf_get_software_info_leaf(s=
truct kvaser_usb *dev,
>                 case KVASER_USB_LEAF_SWOPTION_FREQ_32_MHZ_CLK:
>                         dev->cfg =3D &kvaser_usb_leaf_imx_dev_cfg_32mhz;
>                         break;
> +               default:
> +                       return -ENODEV;
>                 }
>         }
> +       return 0;
>  }
>
>  static int kvaser_usb_leaf_get_software_info_inner(struct kvaser_usb *de=
v)
> @@ -809,7 +814,9 @@ static int kvaser_usb_leaf_get_software_info_inner(st=
ruct kvaser_usb *dev)
>
>         switch (dev->driver_info->family) {
>         case KVASER_LEAF:
> -               kvaser_usb_leaf_get_software_info_leaf(dev, &cmd.u.leaf.s=
oftinfo);
> +               err =3D kvaser_usb_leaf_get_software_info_leaf(dev, &cmd.=
u.leaf.softinfo);
> +               if (err)
> +                       return err;
>                 break;
>         case KVASER_USBCAN:
>                 fw_version =3D le32_to_cpu(cmd.u.usbcan.softinfo.fw_versi=
on);
> --
> 2.43.0
>

--000000000000addf18065aedb05c
Content-Type: application/octet-stream; name="reproducer.c"
Content-Disposition: attachment; filename="reproducer.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mtrx8tqd0>
X-Attachment-Id: f_mtrx8tqd0

LyoKICogV0FSTl9PTighZGV2LT5jZmcpIGluIGt2YXNlcl91c2JfcHJvYmUoKSwga3Zhc2VyX3Vz
Yl9jb3JlLmMuCiAqCiAqIGdjYyAtc3RhdGljIC1vIHJlcHJvIHJlcHJvZHVjZXIuYyAgIC0tIHJ1
biBhcyByb290IGluIGEgZGlzcG9zYWJsZSBWTS4KICovCiNpbmNsdWRlIDxkaXJlbnQuaD4KI2lu
Y2x1ZGUgPGZjbnRsLmg+CiNpbmNsdWRlIDxzdHJpbmcuaD4KI2luY2x1ZGUgPHN5cy9pb2N0bC5o
PgojaW5jbHVkZSA8bGludXgvdXNiL2NoOS5oPgojaW5jbHVkZSA8bGludXgvdXNiL3Jhd19nYWRn
ZXQuaD4KCnN0YXRpYyBpbnQgcmF3X2dhZGdldF9mZDsKCnN0YXRpYyBjb25zdCBzdHJ1Y3QgdXNi
X2RldmljZV9kZXNjcmlwdG9yIGt2YXNlcl9sZWFmX2RldmljZV9kZXNjID0gewoJLmJMZW5ndGgg
PSBzaXplb2Yoc3RydWN0IHVzYl9kZXZpY2VfZGVzY3JpcHRvciksCgkuYkRlc2NyaXB0b3JUeXBl
ID0gVVNCX0RUX0RFVklDRSwKCS5iY2RVU0IgPSAweDAyMDAsCgkuYk1heFBhY2tldFNpemUwID0g
NjQsCgkuaWRWZW5kb3IgPSAweDBiZmQsCgkuaWRQcm9kdWN0ID0gMHgwMDBhLAoJLmJOdW1Db25m
aWd1cmF0aW9ucyA9IDEsCn07CgpzdGF0aWMgY29uc3QgdW5zaWduZWQgY2hhciBrdmFzZXJfbGVh
Zl9jb25maWdfZGVzY1tdID0gewoJOSwgVVNCX0RUX0NPTkZJRywgMzIsIDAsIDEsIDEsIDAsIDB4
YTAsIDB4ZmEsCgk5LCBVU0JfRFRfSU5URVJGQUNFLCAwLCAwLCAyLCAweGZmLCAweGZmLCAweGZm
LCAwLAoJNywgVVNCX0RUX0VORFBPSU5ULCAweDgxLCBVU0JfRU5EUE9JTlRfWEZFUl9CVUxLLCAw
LCAyLCAwLAoJNywgVVNCX0RUX0VORFBPSU5ULCAweDAxLCBVU0JfRU5EUE9JTlRfWEZFUl9CVUxL
LCAwLCAyLCAwLAp9OwoKc3RhdGljIHN0cnVjdCB1c2JfZW5kcG9pbnRfZGVzY3JpcHRvciBidWxr
X2luX2VwX2Rlc2MgPSB7CgkuYkxlbmd0aCA9IFVTQl9EVF9FTkRQT0lOVF9TSVpFLAoJLmJEZXNj
cmlwdG9yVHlwZSA9IFVTQl9EVF9FTkRQT0lOVCwKCS5iRW5kcG9pbnRBZGRyZXNzID0gMHg4MSwK
CS5ibUF0dHJpYnV0ZXMgPSBVU0JfRU5EUE9JTlRfWEZFUl9CVUxLLAoJLndNYXhQYWNrZXRTaXpl
ID0gNTEyLAp9OwoKc3RhdGljIHN0cnVjdCB1c2JfZW5kcG9pbnRfZGVzY3JpcHRvciBidWxrX291
dF9lcF9kZXNjID0gewoJLmJMZW5ndGggPSBVU0JfRFRfRU5EUE9JTlRfU0laRSwKCS5iRGVzY3Jp
cHRvclR5cGUgPSBVU0JfRFRfRU5EUE9JTlQsCgkuYkVuZHBvaW50QWRkcmVzcyA9IDB4MDEsCgku
Ym1BdHRyaWJ1dGVzID0gVVNCX0VORFBPSU5UX1hGRVJfQlVMSywKCS53TWF4UGFja2V0U2l6ZSA9
IDUxMiwKfTsKCi8qIHN0cnVjdCBrdmFzZXJfY21kIHsgdTggbGVuOyB1OCBpZDsgfSArIHN0cnVj
dCBsZWFmX2NtZF9zb2Z0aW5mbyAoMzAgYnl0ZXMpICovCnN0YXRpYyBjb25zdCB1bnNpZ25lZCBj
aGFyIHNvZnRpbmZvX3JlcGx5X3VuaGFuZGxlZF9jbG9ja1szMl0gPSB7CglbMF0gPSAzMiwJLyog
bGVuICovCglbMV0gPSAzOSwJLyogQ01EX0dFVF9TT0ZUV0FSRV9JTkZPX1JFUExZICovCglbNF0g
PSAweDYwLAkvKiBzd19vcHRpb25zOiB0aGUgY2xvY2sgZW5jb2Rpbmcgd2l0aCBubyBzd2l0Y2gg
Y2FzZSAqLwp9OwoKc3RhdGljIHZvaWQgZXAwX3JlcGx5KGNvbnN0IHZvaWQgKnBheWxvYWQsIGlu
dCBwYXlsb2FkX2xlbikKewoJY2hhciByZXBseV9idWZbc2l6ZW9mKHN0cnVjdCB1c2JfcmF3X2Vw
X2lvKSArIDY0XTsKCXN0cnVjdCB1c2JfcmF3X2VwX2lvICplcDBfaW8gPSAodm9pZCAqKXJlcGx5
X2J1ZjsKCgllcDBfaW8tPmVwID0gMDsKCWVwMF9pby0+ZmxhZ3MgPSAwOwoJZXAwX2lvLT5sZW5n
dGggPSBwYXlsb2FkX2xlbjsKCWlmIChwYXlsb2FkX2xlbikKCQltZW1jcHkoZXAwX2lvLT5kYXRh
LCBwYXlsb2FkLCBwYXlsb2FkX2xlbik7Cglpb2N0bChyYXdfZ2FkZ2V0X2ZkLCBVU0JfUkFXX0lP
Q1RMX0VQMF9XUklURSwgZXAwX2lvKTsKfQoKLyogQSBuby1kYXRhIHNldHVwIHN0YWdlIChTRVRf
Q09ORklHVVJBVElPTikgaXMgYWNrZWQgb24gdGhlIE9VVCBkaXJlY3Rpb24uICovCnN0YXRpYyB2
b2lkIGVwMF9hY2tfbm9fZGF0YV9zdGFnZSh2b2lkKQp7CglzdHJ1Y3QgdXNiX3Jhd19lcF9pbyBl
cDBfaW8gPSB7IC5lcCA9IDAsIC5mbGFncyA9IDAsIC5sZW5ndGggPSAwIH07CgoJaW9jdGwocmF3
X2dhZGdldF9mZCwgVVNCX1JBV19JT0NUTF9FUDBfUkVBRCwgJmVwMF9pbyk7Cn0KCi8qIEJpbmQg
cmF3LWdhZGdldCB0byB0aGUgZmlyc3QgZHVtbXlfaGNkIFVEQyBsaXN0ZWQgaW4gL3N5cy9jbGFz
cy91ZGMuICovCnN0YXRpYyBpbnQgcmF3X2dhZGdldF9iaW5kX2ZpcnN0X3VkYyh2b2lkKQp7Cglz
dHJ1Y3QgdXNiX3Jhd19pbml0IHJhd19nYWRnZXRfaW5pdCA9IHt9OwoJc3RydWN0IGRpcmVudCAq
dWRjX2VudHJ5OwoJRElSICp1ZGNfZGlyOwoKCXVkY19kaXIgPSBvcGVuZGlyKCIvc3lzL2NsYXNz
L3VkYyIpOwoJaWYgKCF1ZGNfZGlyKQoJCXJldHVybiAtMTsKCXdoaWxlICgodWRjX2VudHJ5ID0g
cmVhZGRpcih1ZGNfZGlyKSkgJiYgdWRjX2VudHJ5LT5kX25hbWVbMF0gPT0gJy4nKQoJCTsKCWlm
ICghdWRjX2VudHJ5KQoJCXJldHVybiAtMTsKCXN0cmNweSgoY2hhciAqKXJhd19nYWRnZXRfaW5p
dC5kZXZpY2VfbmFtZSwgdWRjX2VudHJ5LT5kX25hbWUpOwoJY2xvc2VkaXIodWRjX2Rpcik7Cglz
dHJjcHkoKGNoYXIgKilyYXdfZ2FkZ2V0X2luaXQuZHJpdmVyX25hbWUsICJkdW1teV91ZGMiKTsK
CXJhd19nYWRnZXRfaW5pdC5zcGVlZCA9IFVTQl9TUEVFRF9ISUdIOwoKCXJhd19nYWRnZXRfZmQg
PSBvcGVuKCIvZGV2L3Jhdy1nYWRnZXQiLCBPX1JEV1IpOwoJaWYgKHJhd19nYWRnZXRfZmQgPCAw
IHx8CgkgICAgaW9jdGwocmF3X2dhZGdldF9mZCwgVVNCX1JBV19JT0NUTF9JTklULCAmcmF3X2dh
ZGdldF9pbml0KSB8fAoJICAgIGlvY3RsKHJhd19nYWRnZXRfZmQsIFVTQl9SQVdfSU9DVExfUlVO
LCAwKSkKCQlyZXR1cm4gLTE7CglyZXR1cm4gMDsKfQoKLyogQW5zd2VyIGRlc2NyaXB0b3IgcmVx
dWVzdHMgdW50aWwgdGhlIGhvc3QgaXNzdWVzIFNFVF9DT05GSUdVUkFUSU9OLiAqLwpzdGF0aWMg
aW50IGVudW1lcmF0ZV91bnRpbF9zZXRfY29uZmlndXJhdGlvbih2b2lkKQp7CgljaGFyIGV2ZW50
X2J1ZltzaXplb2Yoc3RydWN0IHVzYl9yYXdfZXZlbnQpICsgc2l6ZW9mKHN0cnVjdCB1c2JfY3Ry
bHJlcXVlc3QpXTsKCXN0cnVjdCB1c2JfcmF3X2V2ZW50ICpldmVudCA9ICh2b2lkICopZXZlbnRf
YnVmOwoJc3RydWN0IHVzYl9jdHJscmVxdWVzdCAqY3RybF9yZXEgPSAodm9pZCAqKWV2ZW50LT5k
YXRhOwoKCWZvciAoOzspIHsKCQljb25zdCB2b2lkICpkZXNjcmlwdG9yID0gMDsKCQlpbnQgZGVz
Y3JpcHRvcl9sZW4gPSAwOwoKCQlldmVudC0+dHlwZSA9IDA7CgkJZXZlbnQtPmxlbmd0aCA9IHNp
emVvZihzdHJ1Y3QgdXNiX2N0cmxyZXF1ZXN0KTsKCQlpZiAoaW9jdGwocmF3X2dhZGdldF9mZCwg
VVNCX1JBV19JT0NUTF9FVkVOVF9GRVRDSCwgZXZlbnQpIDwgMCkKCQkJcmV0dXJuIC0xOwoJCWlm
IChldmVudC0+dHlwZSAhPSBVU0JfUkFXX0VWRU5UX0NPTlRST0wpCgkJCWNvbnRpbnVlOwoJCWlm
IChjdHJsX3JlcS0+YlJlcXVlc3QgPT0gVVNCX1JFUV9TRVRfQ09ORklHVVJBVElPTikKCQkJcmV0
dXJuIDA7CgoJCWlmIChjdHJsX3JlcS0+YlJlcXVlc3QgPT0gVVNCX1JFUV9HRVRfREVTQ1JJUFRP
UikgewoJCQlpZiAoY3RybF9yZXEtPndWYWx1ZSA+PiA4ID09IFVTQl9EVF9ERVZJQ0UpIHsKCQkJ
CWRlc2NyaXB0b3IgPSAma3Zhc2VyX2xlYWZfZGV2aWNlX2Rlc2M7CgkJCQlkZXNjcmlwdG9yX2xl
biA9IHNpemVvZihrdmFzZXJfbGVhZl9kZXZpY2VfZGVzYyk7CgkJCX0gZWxzZSBpZiAoY3RybF9y
ZXEtPndWYWx1ZSA+PiA4ID09IFVTQl9EVF9DT05GSUcpIHsKCQkJCWRlc2NyaXB0b3IgPSBrdmFz
ZXJfbGVhZl9jb25maWdfZGVzYzsKCQkJCWRlc2NyaXB0b3JfbGVuID0gc2l6ZW9mKGt2YXNlcl9s
ZWFmX2NvbmZpZ19kZXNjKTsKCQkJfQoJCX0KCQlpZiAoIWRlc2NyaXB0b3IpCgkJCWlvY3RsKHJh
d19nYWRnZXRfZmQsIFVTQl9SQVdfSU9DVExfRVAwX1NUQUxMLCAwKTsKCQllbHNlIGlmIChkZXNj
cmlwdG9yX2xlbiA+IGN0cmxfcmVxLT53TGVuZ3RoKQoJCQllcDBfcmVwbHkoZGVzY3JpcHRvciwg
Y3RybF9yZXEtPndMZW5ndGgpOwoJCWVsc2UKCQkJZXAwX3JlcGx5KGRlc2NyaXB0b3IsIGRlc2Ny
aXB0b3JfbGVuKTsKCX0KfQoKaW50IG1haW4odm9pZCkKewoJY2hhciBidWxrX2lvX2J1ZltzaXpl
b2Yoc3RydWN0IHVzYl9yYXdfZXBfaW8pICsgNjRdOwoJc3RydWN0IHVzYl9yYXdfZXBfaW8gKmJ1
bGtfaW8gPSAodm9pZCAqKWJ1bGtfaW9fYnVmOwoJaW50IGJ1bGtfaW5faGFuZGxlLCBidWxrX291
dF9oYW5kbGU7CgoJaWYgKHJhd19nYWRnZXRfYmluZF9maXJzdF91ZGMoKSB8fCBlbnVtZXJhdGVf
dW50aWxfc2V0X2NvbmZpZ3VyYXRpb24oKSkKCQlyZXR1cm4gMTsKCglpb2N0bChyYXdfZ2FkZ2V0
X2ZkLCBVU0JfUkFXX0lPQ1RMX0NPTkZJR1VSRSwgMCk7CglidWxrX2luX2hhbmRsZSA9IGlvY3Rs
KHJhd19nYWRnZXRfZmQsIFVTQl9SQVdfSU9DVExfRVBfRU5BQkxFLCAmYnVsa19pbl9lcF9kZXNj
KTsKCWJ1bGtfb3V0X2hhbmRsZSA9IGlvY3RsKHJhd19nYWRnZXRfZmQsIFVTQl9SQVdfSU9DVExf
RVBfRU5BQkxFLCAmYnVsa19vdXRfZXBfZGVzYyk7CgllcDBfYWNrX25vX2RhdGFfc3RhZ2UoKTsK
CgkvKiBEcmFpbiBDTURfR0VUX1NPRlRXQVJFX0lORk8sIGFuc3dlciBpdDsgcHJvYmUgdGhlbiBy
ZWFjaGVzIHRoZSBXQVJOLiAqLwoJZm9yICg7OykgewoJCWJ1bGtfaW8tPmVwID0gYnVsa19vdXRf
aGFuZGxlOwoJCWJ1bGtfaW8tPmZsYWdzID0gMDsKCQlidWxrX2lvLT5sZW5ndGggPSA2NDsKCQlp
ZiAoaW9jdGwocmF3X2dhZGdldF9mZCwgVVNCX1JBV19JT0NUTF9FUF9SRUFELCBidWxrX2lvKSA8
IDApCgkJCXJldHVybiAxOwoKCQlidWxrX2lvLT5lcCA9IGJ1bGtfaW5faGFuZGxlOwoJCWJ1bGtf
aW8tPmZsYWdzID0gMDsKCQlidWxrX2lvLT5sZW5ndGggPSBzaXplb2Yoc29mdGluZm9fcmVwbHlf
dW5oYW5kbGVkX2Nsb2NrKTsKCQltZW1jcHkoYnVsa19pby0+ZGF0YSwgc29mdGluZm9fcmVwbHlf
dW5oYW5kbGVkX2Nsb2NrLAoJCSAgICAgICBzaXplb2Yoc29mdGluZm9fcmVwbHlfdW5oYW5kbGVk
X2Nsb2NrKSk7CgkJaWYgKGlvY3RsKHJhd19nYWRnZXRfZmQsIFVTQl9SQVdfSU9DVExfRVBfV1JJ
VEUsIGJ1bGtfaW8pIDwgMCkKCQkJcmV0dXJuIDE7Cgl9Cn0K
--000000000000addf18065aedb05c--
