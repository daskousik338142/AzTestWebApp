using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using SimpleMenuApp.Models;

namespace SimpleMenuApp.Controllers;

public class HomeController : Controller
{
    private readonly ILogger<HomeController> _logger;

    public HomeController(ILogger<HomeController> logger)
    {
        _logger = logger;
    }

    public IActionResult Index()
    {
        ViewBag.WelcomeMessage = "Welcome to the Simple Menu Application!";
        ViewBag.CurrentTime = DateTime.Now.ToString("F");
        return View();
    }

    public IActionResult About()
    {
        ViewBag.Title = "About Us";
        ViewBag.Description = "This is a simple .NET application with menu navigation, designed for Azure deployment.";
        return View();
    }

    public IActionResult Services()
    {
        ViewBag.Title = "Our Services";
        var services = new List<string>
        {
            "Web Development",
            "Cloud Solutions",
            "Azure Deployment",
            "Application Hosting"
        };
        ViewBag.ServicesList = services;
        return View();
    }

    public IActionResult Contact()
    {
        ViewBag.Title = "Contact Information";
        ViewBag.Email = "info@simplemenuapp.com";
        ViewBag.Phone = "+1 (555) 123-4567";
        return View();
    }

    public IActionResult Privacy()
    {
        return View();
    }

    [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
    public IActionResult Error()
    {
        return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
    }
}
