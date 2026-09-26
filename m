Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA543A9DA5
	for <linux-can@vger.kernel.org>; Sat, 26 Sep 2026 12:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790427168; cv=pass; b=qCBVZZhwl0vPl0gECsdHlMLBOHM+AFOjY0bOKhLSF+5bahcnqBigkhVakQwf6rzGy01jjL42p/FsAQ1qv2PsXhvlYfIFkQZtwXnY2ntAlpttnKq0KG6cPZYyTR4avr/vrAR9g4jQYd4vzC64KmmjH+FU/rWhDc/pfLAuVHlmH7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790427168; c=relaxed/simple;
	bh=Kvts8LNu+OWd966oIXmCICAbccRKosY/VKYtUxrxvVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EmBFWWxJJsgckIuKOLZYvG8v+FX0fBye9ae9hwjUQA+5zSZ/Eb/38XUSP/TNVaOfIStqKiWNBALzPGTkvLdfqibtgIdLpTBtQD9g41v0MckUmm/ib4XaTJIrkJwj9+QVDs4Og9UMxT/VMBW7eBjNT631i8yDAC4o2arxhLix0BE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hclHfs1m; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hclHfs1m"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485984ebf5cso1303719f8f.0
        for <linux-can@vger.kernel.org>; Sat, 26 Sep 2026 05:52:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790427163; cv=none;
        d=google.com; s=arc-20260327;
        b=Q6pVnAQmXm4Ef1G2d/5fw366cjMVSZhQUEWZTScv0xAEoiuxYM5fi37WwsUU+Dnzvl
         Q8uMXA9CdaRUohL7C/ialfaoVPfvI0XPxF6Nja2nzYPLKjujgtALlfC3PCM2Z9aYdOHT
         QhVUl9AooYUar/CdbbcOU9YJ91VIPGCRMxl633udiIJyTQqt6FjqAgG5xwmMo675hrrV
         Dgf4kwkTw1O3lwQC1Ak6pdqqCdYDvMH5vS04XnHI/mZN/XPZqEZxVYMHRQw4mWqHdbkE
         iTVozkEQauENc4EkJGlShxhu/WRGPvvcW5n18a8tK3ULBBpldj/GGT5jrzbN22zYkJ1I
         QogQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Kvts8LNu+OWd966oIXmCICAbccRKosY/VKYtUxrxvVQ=;
        fh=FLmiqCcveRwHq98YNi86ANwJcLhOvQnaYTJdQwTLZfQ=;
        b=m4VAFZrqgZhGgTXr7Il+sICpd4sDJF4X/osDqX2YBeAQEjWCBqk6hsGiFC9xV1iTpg
         Ws1QFPDphFUYqD73R0f1UgAB70gG9lZkCzT6IZ2zcPwEvB2Yqk8t51i8OU0CQ5ztTbQY
         UddX676Q8uf3esc11/6LslYHG1wiHAl9s39RhCrDmMKK/W1mBzLe6mLlr6Q+sIXK3PM1
         /fs9vJwLytBIhuFAhkvboj1ep0cHm5cngrEu6XkWnjLnbTJ5eBlL0xFybbSc3962WBAf
         P5Vp0FHb4ELBS2TmGjAW0MYWMDnNSyFFxJ3LTnObfRalRMH96/UtNB3s+ArfB9sFYrLl
         pFAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790427163; x=1791031963; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kvts8LNu+OWd966oIXmCICAbccRKosY/VKYtUxrxvVQ=;
        b=hclHfs1m/bCJgEcJZYiDFRPRQpnW10FD/B6dbCDq2Q3zVJx93wK40OwUzbFYFJygYF
         ijJX0eWvKjgncAbUhB/GLoGa+W2ztRsS2vGpyFFtHIHlC46isrDBPEFQo+PeJrKTKJp6
         x1XssO8i1UiiUrYSh+l6lciIeUaNkACs4jFV6Y7d+CR/iGL0ugfL2mphRdNGDuMBJNvi
         D7lnd/U9ZoQETXpEM9vh4kthE0bBhIb6ZzPFHQhY3867eTNqzGZPYKcM+QnE2/pXOHsb
         cd9chLwIWxLfzLQaqZwsC1FaCkvKZyc7aGbGoU12a1S2dIxzKQnylRqrHQ0JAYkD4gcO
         eUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790427163; x=1791031963;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Kvts8LNu+OWd966oIXmCICAbccRKosY/VKYtUxrxvVQ=;
        b=zqJej3NDsaQzfnrmDFsDHK1FxCr7mY6MHxZcRCQC0r18gTTq6ZKzGLJwQw3HXCbFIO
         Y30SJurw0c7GBDTjhdF6gWZTo2aUrM2pPPKraZ0E/A6oQ2O41w71f/yCAJXpIlg/nE2p
         ySyOV3kan2EyYGBYOj7uo0uwXKeX33sYY2Gx/bIKEVKRUrHY1eVdSsurGCkfKURao2r6
         o/n2NN877rRsTtppW5yhiLHRJFwPg9dJR8dU7Xb2i0lNL/08g+Y3NYYUSERsklcOFB8o
         yA/yOabJablu8oLy591Knr406NaCIGAK6oihGKcEx3qq9Lz8+TEGiVs7EGJaw705JAnX
         AXjA==
X-Forwarded-Encrypted: i=1; AKwUvBxmtyLcbi4CgqWmeb76g7NVWAepn8Y500oo356PV2PUW+s68tR5K1OpPEreQ+W5w/BK8/cL9HA7hiI=@vger.kernel.org
X-Gm-Message-State: AFuF++msY47DCXCuqEaJDj+YdgAh3tYf9DU/QOMjZysTgZ07z7wh4y3Y
	k6EbQs6bi4sI7iCHb+1Yym8ygLICk//FZpOjBRXu+Ip/k1VKHtcSa7p14srf1LeNAjs/RjFRETR
	4yYoy68005a2jVA7y0Qe4QK147dqOHsw=
X-Gm-Gg: AYBFou0bZxlNjXJcj12W9fLu9EdqC+e5q2x7NngmZGdZTk9zIxrvHYK9kB4AuOwlTub
	Co32vIiC0h5SrqWbbdfsyLzDBk4E+8EmPXIZxzUlhX9xnsbADAYllj4X7tc3JrHvYYMEYsI1/Nq
	45RKVmMtxjL9aOgKdVTrjTnt49aSspB0v3/oFmlf1IeaFx0C5OR+UzgH/U5Qz+oe4P3Zg/4ifQi
	b3bjSP5q3Q6ohuKLnd4rWDsNN5yjcwuOBZ72rbPcwiYUs5QHDcQXG4siN7yMHSCEAKeXtKRLASm
	Wdt2ERJy/XQ/jb6LQ8Q4Hbman4yCtN8NKpbg7bOcninbTUicibRjXH39AifWpRtzZJPMOvLE6LB
	4oMYYNTDG1pGJvRiC/bN7qDJQLcc3H0wSflfCZyyuX+SIt5Kxv8VDHJ20Wzh52HbAtw/Ty1FJZW
	lq2ahF8cOs0x3TMCU93wf52wP2DkPXu9wBd5Mmz3lsw4tzKveayLRQem4wDIVRa89MVcMrasDrN
	DzsnnIqu9mh2RuNe/LHt3IrUtJ0VAvJzQA=
X-Received: by 2002:a05:600c:1c1c:b0:49c:fa21:1c7d with SMTP id
 5b1f17b1804b1-49fe7babc98mr166966135e9.18.1790427163252; Sat, 26 Sep 2026
 05:52:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916124236.1389-1-joshua.crofts1@gmail.com>
 <DLIC0I1VQLHE.13KVAJJ5FUYZN@baylibre.com> <20260918131504.00005d2a@gmail.com>
 <DLMI87KFXHTQ.SWLSTWGCM2T4@baylibre.com> <20260923092437.00006b61@gmail.com>
In-Reply-To: <20260923092437.00006b61@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 26 Sep 2026 14:52:31 +0200
X-Gm-Features: AclHuK_D0j8esuuFZJv-lGLLnVq7Xcq0lvcWbnjnEOQaLlZlYUjvLFoeQECUknE
Message-ID: <CALoEA-zkr2sj5tvN8RGAGhaNQQLBjZMRY9nwTn=H1c895O_Wyg@mail.gmail.com>
Subject: Re: [PATCH] can: m_can: pci: add missing pm_runtime_dont_use_autosuspend()
 call
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Sept 2026 at 09:24, Joshua Crofts <joshua.crofts1@gmail.com> wrote:
>
> On Wed, 23 Sep 2026 09:06:59 +0200
> "Markus Schneider-Pargmann" <msp@baylibre.com> wrote:
>
> > On Fri Sep 18, 2026 at 1:15 PM CEST, Joshua Crofts wrote:
> > > On Fri, 18 Sep 2026 11:24:09 +0200
> > > "Markus Schneider-Pargmann" <msp@baylibre.com> wrote:
> > >
> > >> Hi Joshua,
> > >>
> > >> On Wed Sep 16, 2026 at 2:42 PM CEST, Joshua Crofts wrote:
> > >> > m_can_pci_remove() forgets to call pm_runtime_dont_use_autosuspend() on
> > >> > teardown, even though autosuspend is enabled in m_can_pci_probe().
> > >> >
> > >> > Add the missing function call.
> > >> >
> > >>
> > >> Can you please add a Fixes: tag?
> > >
> > > I guess it's not a problem, however we had a discussion in the
> > > USB subsystem whether this type of patch is a fix and ended up
> > > agreeing that it's more hardening, hence no Fixes tag.
> > >
> > > Alright if I just append the tag here for b4 to collect?
> >
> > Yes, that's ok for me.
> >
>
> Fixes: cab7ffc0324f ("can: m_can: add PCI glue driver for Intel Elkhart Lake")
>

You can drop this patch, as I now have a patch queued for 7.4 that makes
PM runtime call this automatically on driver unbind [1].

[1] https://lore.kernel.org/all/20260919-move-dont-use-autosuspend-v1-1-f6e2d1315c23@gmail.com/

--
Kind regards,
Joshua Crofts
