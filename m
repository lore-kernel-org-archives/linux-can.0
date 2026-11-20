Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795196526;
	b=j/npEPa2zcb166nGEIid7vygbFNrUN48SdjejswRxkSurhOZSyRQIubVshp+lbyQChVd
	 uClGHX7KTPvi0WNnHI/7Qck0ksrKtIWi4uR6cOsDvg7bP9Z+OkNls1dgqQpMrv4Lfkz8p
	 md6kIg+GyEicQlYSD5nCNhWXo7krkzQXa9NkT89byv33aoKmztSVKTzhRzzBc917v26wI
	 3JIi9v2sDF8HEp5yNW8+bq4eUG45HesuNCgP+hSMoNiiNboOLYe15jNl3/DnvfNY+Fe/O
	 VZqZW6il2IqL6F1R4XGMRyugGNnyyRKrXIc4vSN3QtZNZCbeKqlFOGWhP/S84iKzvJQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196526;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=uwdDvq8gf/8FaQGY9k5cefpkzPVlUilKxb2tJP1eGzo=;
	b=K3Zfuc/0ZQwzOn9p2FRZWPdH31kqTxCOnkrIedYjOfUTH+nV5c3GGbZ1OnPMb8gzcS9p
	 +SEW31Ad8sbd90UhGmbMDNQWT9k5AW+j3mbRvD1eWnUrXoIJ4uXjg/1INc/dieN30paU8
	 Dio9o+gNl7mwv/7foMNjiT3sjB2Gxc+toCy41Gc2Pt8zclUUaYhnll8G3lz0uINfYyIMb
	 QDH9HkBriFVK4FnchrMklKnYJPI1piydj/ueiISF+HcApDFDW0g/UQ9PMZGYQ8bpyPUcn
	 n3xEZONFL6ws8xb/45Shaj9Os8N7nc9AYRSW99kpXxTrtcHnGfA3m+v1atu1YaOJmQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="mJ1Ij/nF";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FBC606A336
	for <linux-can@vger.kernel.org>; Fri, 20 Nov 2026 17:42:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6FBC606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mJ1Ij/nF
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-55c7445cf85so321521cf.1
        for <linux-can@vger.kernel.org>; Fri, 20 Nov 2026 09:42:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795196525; cv=none;
        d=google.com; s=arc-20260327;
        b=iKx5+nvUTOQuxw5lll92QXgjNoYrdThuEx1tvq2SNYNfDJvyzgMqoldOaJrkjE0FjY
         4omolqhqt5B09ieC7FeXeHDIGz0N050c/u3Eo5oLgSR7ufMytxhHa0/sfOU+OCwgcbTb
         HUNUuPy6zKwdVwvd8iT48gegRq4Tl1UMfI5lHANpO+ENIF8P5ngktYHeImYnq/Xjiz2O
         1m7E33E1t3GAHhdM9hd2y49UrmaPZvIn1uo61CVLHkLQEX82xJaWaoJOsNG6tkyyB569
         +pCCYTCxRSl12ohpwC6TggfCc63tZkIxLU1rn4yzh7GSMQ5hv6k3SRN0EElgZ4Sb1QHU
         u2jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uwdDvq8gf/8FaQGY9k5cefpkzPVlUilKxb2tJP1eGzo=;
        fh=x7OgrYBE8B6Hd3Y4ihqPj8lA4bOi5ku2dN4CzJrMAk8=;
        b=SinvsDG3njqmcCVT5ZvQWAq4pd2orz1NkpYyuC0PYNlPfVH9ym5r2aCZi1UFF4cBVd
         gzw8hgr+x0lxrE1P5C/tESfXgVzkhAr54Hzsp6JBeWCNc2JxwJCnv5sL6z5Xbb4Fla6L
         iXGV2dXFKECRvXPo6i99Kq7B0OzKogcvWXwZQwILwvGHn526QDRpgAdaKW7/akC1Xx7u
         lsCpBpgJdcxov57CiIxeZ/jJcc47eQRxkDWM8k8melmFIZ+H7w6TAe1Y7xzYfMEmW/qB
         i2ml4h8fUeyTd59nW2zXFCSHezzc+dfnKgbRoYkFhcFrUN6RubFYyOU9CjT+GOFHbDDI
         d9Lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795196525; x=1795801325; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uwdDvq8gf/8FaQGY9k5cefpkzPVlUilKxb2tJP1eGzo=;
        b=mJ1Ij/nFdAEldwa1bKqHJeawNzo89wlrU53BuQWpRah024pVOsGHr2oE28U29HAjXq
         NsZoZe94qH2vwDrlK/MLLgTg6kxr/kj0UdSuJBRgSAdQSWfJeagQ7/w0kpmeLw4lhSXd
         R11KvgR4jvIo0OYszlLSmRcigICxUArNvJI5QBPwxxpxAnqCz3iQkRLyjf/cdBr8ZjoK
         KNUT95tk0V0HOT7Jp6WSDC2i2xp37V8iDovu2VLtzS4Cw+58d9+/9v3XnXD0f4G7sq4v
         6IcFr6QibdmO/xCGSjm8I1SJv3XHScRVpMex/gS6sVErFVoqUCCrnBaq3QgWr1pDqJNL
         wb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795196525; x=1795801325;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uwdDvq8gf/8FaQGY9k5cefpkzPVlUilKxb2tJP1eGzo=;
        b=MssT96nObArGVHUjM8XS0bXbf3jUalr2q6RWfBKAcTW0gWJ7H/IwWbff6u5BZzOD4n
         z83al0Kvfin3j+cn3i3ciZAsroiYvESkIEHRSy/oHAZGhEj0nLHSoxgFi2KFwiyhgRyk
         I3cRFBQ9yd+iHT/xG3iidAqQSXSkOIywogGzqIuOHiQbybuuYbCQu6LYAbvOTLOsJl7h
         O51oQRCnI4b4wZmqht1bslfcn5I8YmWeZFEhV8yXxRXjaoZi/NNp19ajC7JTpOLBmBjO
         5Q/KKZENSxMm9/TUEynWo4Fq0cSGUfFohFwHwl/C09cLPNz29naHOfB/lNaPLrLqha5N
         QdIA==
X-Forwarded-Encrypted: i=1; AL+hErGtONIgksgoQdFtBXg6qqgKDk2w6zha2u0wkiIEYw2xhV4OGj5ZspLvV4MfQubwtuqGOwGcLM15L6w=@vger.kernel.org
X-Gm-Message-State: APuU4Z8KPNbVgbXg//gpWJS6otoAQM610cmq+Y0tdHKMrqWpHGOAuP0H
	2FRmPuj57YwP5BFpZMS4VRAxpVp6Sw42HvC+bBQJScZ5SqrpGlwGELcB41NakpKSqnvrD8s/pp2
	HdFLzzGC0r4gGS0/Xe0Fj0Yzt32IWVgzVr609vv5J
X-Gm-Gg: AYBFou0KEwDlHpvFMSN67TK+BDR1ZsIdG/4c+vbxCxW4t+0MdH4cFocxcrK+KnBxKV8
	6uxDZI1okeXtTF2HwQMRXmgHUIqTdRDIp9BC/H4lc6Atke/RD3nx9WyBRq0euxoxGw3XCG0Rz5E
	SOuozv7BfG3HozAB00z2sRnfJsAkWKYCON5FvOIjDWPeyufzg7WvO9Kp2RCPAkWg/hDNb7OOOaS
	nKYOBzfMN8dZsec8rdDlZ+8BY9PEihYMi8zE35AI86ebQm3f2gJpqX2ZG0srFNaOmEh+isbh7yE
	8mwmx8AKmH9frBzQ2WkIOR8dVKd1aj5gI9yRAaf7AcFg6Y+QWIoESobSfFtj9yi4ae5guFX4JK4
	DG1vrdrXj1ETLVjwNQYdOLMxNdkGmiRNzlYXt
X-Received: by 2002:a05:622a:5a17:b0:531:282:6560 with SMTP id
 d75a77b69052e-55d7a3bb532mr19021551cf.15.1795196523725; Fri, 20 Nov 2026
 09:42:03 -0800 (PST)
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119170722.1524088-1-irogers@google.com> <20261119-magnificent-ecstatic-alligator-3f4816-mkl@pengutronix.de>
In-Reply-To: <20261119-magnificent-ecstatic-alligator-3f4816-mkl@pengutronix.de>
From: Ian Rogers <irogers@google.com>
Date: Fri, 20 Nov 2026 09:41:50 -0800
X-Gm-Features: Aa3M54ogoNwKUPyvyvGecVyjPhxTJ1dmEEtQ54WzRJLYnFxgBCjMRa5J1U0aCPg
Message-ID: <CAP-5=fUxckfL0ZCa9nVf2sOAdinw_HoVkd1CY8PwYnpKFxLWww@mail.gmail.com>
Subject: Re: [PATCH] can: softing: lock card->fw.lock unconditionally in softing_card_shutdown()
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	Elkin Cruz <elkin@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 9:27=E2=80=AFAM Marc Kleine-Budde <mkl@pengutronix.=
de> wrote:
>
> On 19.11.2026 09:07:22, Ian Rogers wrote:
> > softing_card_shutdown() calls mutex_lock_interruptible(&card->fw.lock)
> > with an empty if-body ('{ /* return -ERESTARTSYS */; }'). Because
> > softing_pdev_remove() invokes softing_card_shutdown() before
> > unregistering netdevs or removing sysfs attributes, a pending signal
> > while card->fw.lock is contended causes mutex_lock_interruptible() to
> > return -EINTR without acquiring the lock. Execution then proceeds unloc=
ked
> > through IRQ and DPRAM teardown and calls mutex_unlock(&card->fw.lock) o=
n a
> > mutex not owned by the current task.
> >
> > Use mutex_lock(&card->fw.lock) in softing_card_shutdown().
> >
> > Found via an x86_64 LLVM=3D1 (Clang 21.1.8) allyesconfig audit with
> > -Wextra-semi-stmt enabled; fix and changelog drafted with an AI coding
> > assistant. Build-tested under LLVM=3D1 W=3D1 (-Werror) and -Wextra-semi=
-stmt;
> > not tested on Softing CAN hardware.
> >
> > Fixes: 03fd3cf5a179 ("can: add driver for Softing card")
> > Fixes: 47fa0336c1b7 ("can: softing: softing_card_shutdown(): add  brace=
s around empty body in an 'if' statement")
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> The driver is being removed in net-next.
>
> https://lore.kernel.org/all/20260815103428.117201-1-socketcan@hartkopp.ne=
t/

Thanks for the heads-up, Oliver and Marc - please ignore this patch!

Best regards,
Ian

> regards,
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |
