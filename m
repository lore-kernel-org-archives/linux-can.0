Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A155F1F1917
	for <linux-can@vger.kernel.org>; Tue, 17 Dec 2024 13:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734441295; cv=none; b=hmP+xLPQu1BlPjoSVBzaDOF5JeRI8/LUMhaFbQpwdwocdGCfZArRFTS7hvCFvcMcaNNJbjtQz7cpiG3rOcaJZS4UCmlwI0ggQ5IeHUYhny/lvhRl2AvoXXkTfQHDQBkdPdxE3Z7hgmmIL6H3aXXYYiWIt99TocMDXTn7EHtg5RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734441295; c=relaxed/simple;
	bh=0tCzv5xhpV9X1fjNhjxKI6ZrerZtZecCQQ4OsMzM4CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BqNO6yeMZVy5MdCfhIry0EcRoMV89v6ju01y87WGlgXw352iws4IUFEAXNGGWPexWcSJe5BmKhj0wuo30AO+BtQpaf0ydIBWDBp9Lxpl2dusomLYi74CY4D579lCRzS9M5kQwletn6mfwhIAIz0sYA02CmQjNGI5X4sfUuMnfI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zg3wHKxY; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zg3wHKxY"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-725ef0397aeso4648524b3a.2
        for <linux-can@vger.kernel.org>; Tue, 17 Dec 2024 05:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734441293; x=1735046093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yG9pmPYM+FmCPsypHUh7JqBaVT3IuwVxciSup41Kr3E=;
        b=Zg3wHKxY2B8LyFqegSLY8f7ZOde00S7jdDzQfv+UfOYD0NPqmJ9e4uddKc0i7yEDAS
         zgL2tsRpYLQ2tu6gKaF0qlijqfTuNclNbV4pHRmfCZLNFy6ehMFQoGYyDejr6EDjMmhT
         nnNfh5YYiPfhyldyvoscruPemt2tpkgye6qo8/cv/dnTic2xbTY33kuFxnuy9mOsq313
         Np6/ZX/u7YUONP2djR79ce8+16rNyPZxVcIdhtp+hUcSHCpM6IV4by+0Fm3xJtqtrpk9
         p5O0teDi6p8RYg/Jc806Z3tM6QpW/K0EN/PeN9U74ekjFCwOFFZLTxgx1/xIsn1GMf/9
         A0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734441293; x=1735046093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yG9pmPYM+FmCPsypHUh7JqBaVT3IuwVxciSup41Kr3E=;
        b=j/PVhX6LgE4laFAaNw+3wxT/ZnpoF3KrRXbXOK+FsicjR8xrihr6yamQrnUZYxx5qx
         HgAPmn3IEjo18iIH5oFZAfbv71rUASLm0clw5w4cwWnXYNMlh9FCXH0C+jjDIyDOTRxA
         xNzS50q3mt2gZXLh6wd4ezd3Uz1ogjk6eWe5JGwDbnEg5lBzTCwbTE1I4wUygJY57Lui
         ZS9osq6tKk/Ex8e4y3gFwKRGfN+d4J+mzPdalxGvv73Yy7Jx2HStIOvbG1curA125WDU
         CPmamw3WVF1NX2jFaMo4sXdv+I9/1H6YokPOYFitIcqxcSxbqWp5HZB3XOHHvEsyxkNw
         vFRw==
X-Gm-Message-State: AOJu0Yy6vGuqCD2MXq0qZbsUpqu2ghXJlYBtx0ei1GRDYGxSnszMDmEz
	UB1XdAwGbdmWzfWsbPSrclSxinXAiH4tnK2qjs3sme2ChjqWjw7u
X-Gm-Gg: ASbGncuKkUXBcOqWNu5clgIYi8gihvFG/BCuRzvAzkaQXA+284U6rDKkUbZt5VYuKox
	XbpTt83gnoXdK8Lpyy7K3D2GTzOGCmEvm+84ltf5Yb9Rc/v/438F82cguhE8uGzCGYRNbA7+dDm
	/8eZi8JW7PlL9CH8wfIqcQMX2w5j9HuWxgAQ/9ia+OLS9XG/9C8IaTrFGwaFGbqxkN4Wrk64J+A
	E75fP4OyC1THpCqu/UsX23bYa5V0CH1PWNqtE4jsG2rAZ6qC5E=
X-Google-Smtp-Source: AGHT+IEILYI3hlKcGTRRKB1y+Q25MdfzaTw6g5UgiFKls+/PA2X4+W0g8n+apl5DmzosM2xjxD+f4Q==
X-Received: by 2002:a05:6a00:1250:b0:729:49a:2db9 with SMTP id d2e1a72fcca58-7290c24ef90mr21491952b3a.21.1734441292919;
        Tue, 17 Dec 2024 05:14:52 -0800 (PST)
Received: from debian.. ([103.12.224.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ad54f0sm6583410b3a.57.2024.12.17.05.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 05:14:52 -0800 (PST)
From: Renjaya Raga Zenta <ragazenta@gmail.com>
To: mkl@pengutronix.de
Cc: linux-can@vger.kernel.org,
	mailhol.vincent@wanadoo.fr,
	martin@geanix.com,
	msp@baylibre.com,
	ragazenta@gmail.com
Subject: Re: [PATCH] can: m_can: m_can_dev_setup(): set CCCR_INIT bit earlier
Date: Tue, 17 Dec 2024 20:14:49 +0700
Message-ID: <20241217131449.86794-1-ragazenta@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241217-fair-misty-jaybird-2d72f7-mkl@pengutronix.de>
References: <20241217-fair-misty-jaybird-2d72f7-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 17.12.2024 19:25:32, Marc Kleine-Budde wrote:
> Can you check if
> https://lore.kernel.org/all/e247f331cb72829fcbdfda74f31a59cbad1a6006.1728288535.git.matthias.schiffer@ew.tq-group.com/
> fixes your problem?

Hi Marc,

Yes that patch fixes my problem. I wonder why I missed that, I think 
I've seen that before.

Thanks,

Renjaya
