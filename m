Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D7F318EE1
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 05:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783403174; cv=none; b=F7G5nXg8ucOW83sw7vwhLQ/zYh8JREkR3Or5yPXeoyldAVxU/Dof0b8qHoUXMtKS1KIe6N+IYzP3QMvkyE36wrkm19LdW1XtALmfIZ+wo+NmU2BmYHHh+H40bFTPfFS5B8P442DqTmm4qqo+pyN6FqY/owWlYnYzWGyJ2VHMUF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783403174; c=relaxed/simple;
	bh=4HPhfOG3J+AvG0gshIvUmJB9sKoFyNn5WUNK/lApVnk=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=eZjkrw6wWcPO+9Gu1w/emwWtFLqoXLFiD7XPyc3xq7hzI+afsZ58wpkyyYzj+YmLkDk7X96rZrmcBQMpEK6cGnEmi+elx5dU/dAKj8SorbfmTfg08TgrX0dwTmQUBBSdS7RD4I/KJe74C80XpAMLNzZmgGU2kw2ZMMQUgqgJk1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dynetrex.com; spf=pass smtp.mailfrom=dynetrex.com; dkim=pass (2048-bit key) header.d=dynetrex.com header.i=@dynetrex.com header.b=JZMDFh3k; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dynetrex.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dynetrex.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dynetrex.com header.i=@dynetrex.com header.b="JZMDFh3k"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-845c92bc464so2695745b3a.2
        for <linux-can@vger.kernel.org>; Mon, 06 Jul 2026 22:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dynetrex.com; s=google; t=1783403172; x=1784007972; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4HPhfOG3J+AvG0gshIvUmJB9sKoFyNn5WUNK/lApVnk=;
        b=JZMDFh3kpGLPHRBp9VBMsARSCoWugReTaRb9GlP9teXxcQtPJs4C7PwQM83u9htXyn
         QH1J1KbqGsjayU6yJt6fwVvhbNUkpsUHkBzmtscsZuku7bnc6KsNMoa97lNY4tpaYYdB
         z4h4MjhKL87wt8NFZeM394z+qVoFRKvT30pgXyPXy9esbPfmktHKJ3mryyvq4j+8DYpJ
         IZIvJ8Cgi2VBSWK6KDFOUmzXML2enTv6Ow+wfU1tGHoGkivR2tMD5KBnAZAY5RLSUIbY
         M9eKPijBT3Mr+ED6B2PostArUALcusZ3clRePgE8JLLLrABVPI13LC9n2zrL0J0zUH2L
         5CGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783403172; x=1784007972;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4HPhfOG3J+AvG0gshIvUmJB9sKoFyNn5WUNK/lApVnk=;
        b=eFXuCc0cOHCZN8miKEVqJENrDahNhk+Oah8Am3O12IOXl0i6sqgI/TW3krSxYd6xQH
         a06Lni1LT0vRZ/Jn6qu+OSn0/0jKX02dCa3uyw6hmzZ5doxuFo/3NcsXoK7sQhLmNc/W
         zVbKBzyEI45oKKFZKhZffkdQi4Xu8mGgTjVApdRT4KdWdHyKMoON6rKrhImO2PoqQ9EW
         c5OnEIEz2+sxM5t3mc1OhIf/KJHVXFgeoNKqAZF1kLRYyKDSKw3YWgTCRQQ9lag0345B
         MfrOgN39KtAjHsVlLR723O6JUwVdHMO3uxV3p/wlUDs/vGKWn9tKOOJ23UvEAQwlzsRz
         h6Aw==
X-Gm-Message-State: AOJu0YyP/gHtWeEXloI1wAv6BmGvjIQneCcz/F3x9ENS19rcj31ERdDm
	bapXdseDM4PU9xLPu3iWFNzEYV9meLyQRVDqmkAvA5ncvDizMPlNwJnZAruUCx8TDCxf7BJqPbU
	g7FrhyAhpo7nRTBRaO8i/hQ71GNwLoVKV64QQNA8ZckehpNHATmoClXL0D0WPqRiiSkE+uXdvI3
	ay/wJmj3naRUGR/PhZw0Gaxl7jgBx9adz5JARY91ZLJfcHstk=
X-Gm-Gg: AfdE7cnTOaiK4mM6zX06SddNCxthqa1EyUHEIRrgRWkSgidJzTRrPy8SDM8mPIruB89
	BW/Cfj/pO/Wbqp4GHEAPbar0pXeP8YTbxHmj1spj1YfxwcZKZj/0xiYIO1ObUrW43AN5yhTU2rf
	gxhmAfmGRs87R4hTSWXiX43Bq+wPDK8f0yb7Xw5LPvNuVP219bYbX/T2+3DvibqiPadwCNEVXlm
	vNTMeDM1fLHuQ2gs4W7u3KPIMUCjNcq0wqQLMqB3TtCaqBqG58Tk4WKOwcwJKmtx0MIcNcI7jNW
	TIwxjGpg4LcpQi5C3n200mACtTZLIZ40qUwwg3q0/g0UkloLOTZxeeBTo/6qnt353rpmoc0WZ9Q
	vyhebu1PbjmZRMQOCTSEVtogFYn7+SjhnFefEVxs8K8PXlxvW2SeSZD3nAQZF1JF60Rm9To2bQT
	8eHdlf2MF4IjWRPLHlsnP98JKGKtsf
X-Received: by 2002:a05:6a00:2e08:b0:845:e04b:565f with SMTP id d2e1a72fcca58-84826cc57damr3429141b3a.14.1783403172200;
        Mon, 06 Jul 2026 22:46:12 -0700 (PDT)
Received: from smtpclient.apple ([170.203.201.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6bd1078sm4766048b3a.24.2026.07.06.22.46.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2026 22:46:11 -0700 (PDT)
From: "Dynetrex, Admin" <admin@dynetrex.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: [REGRESSION] can: usb: f81604: TX broken with "short int URB: 9 < 12" 
Message-Id: <A3834A07-5639-4779-844F-C5843DFC3928@dynetrex.com>
Date: Mon, 6 Jul 2026 22:46:00 -0700
Cc: gregkh@linuxfoundation.org,
 peter_hong@fintek.com.tw,
 mkl@pengutronix.de,
 mailhol@kernel.org,
 stable@kernel.org
To: linux-can@vger.kernel.org
X-Mailer: Apple Mail (2.3774.300.61.1.2)

Hello,

I found an issue with a patch applied to the can/usb/f81604 driver on =
2026-02-23.

https://git.kernel.org/stable/c/36ead57443146e6b730ce1f48ca3e9b17e19a3d2

The patch added a check to make sure urb->actual_length is not less than =
sizeof(struct f81604_int_data). The issue is that the interrupt data =
from the device is 9 bytes, but sizeof(struct f81604_int_data) returns =
12 because the struct is marked __aligned(4).

This causes valid interrupt URBs to be rejected. After this patch, CAN =
frames no longer transmit successfully, while before the patch they =
transmitted without issue.

Each transmit attempt logs the following in dmesg:

f81604_read_int_callback: short int URB: 9 < 12

Please consider either removing the __aligned(4) attribute from struct =
f81604_int_data, or using a constant for the actual wire packet length =
when checking urb->actual_length.

Kind regards,
Alex=
